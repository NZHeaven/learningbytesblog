---
title: "Dockerizing a Jekyll site/app and deploying with Nginx"
date: 2023-10-15 15:29:00 +1200
categories: [Programming, Ruby]
tags: [ruby, programming, docker, container, how-to]
---
## Introduction

During the creation of this blog, which is built with Jekyll, I wanted to create a Docker container so that I could deploy it on my existing Docker infrastructure. I was unable to find a good guide online, so I thought I would document the process here to assist others who need to do the same.

This guide will not delve deeply into how Docker works, and it is expected that you are familiar with basic Docker usage and administration.

I will show you how to create a multi-stage Docker build. The first step will leverage a Ruby container to build your static sites files, and the next step will create an Nginx container and copy over your site to be served.

## Creating a dockerfile
The first step in creating any container is to create a Dockerfile. This file contains the instructions that tell Docker how to build and create your container. At a high level, the process involves taking a base container, copying over the necessary files, and running the required commands to get your container up and running.

### Step 1: Using a base ruby container, build the static website
Just as when building locally, our initial step is to build or generate the static web files, including HTML, CSS, and Javascript.

The command to build these is:
```ruby
JEKYLL_ENV=production bundle exec jekyll build
```
That command will instruct Jekyll to generate all the necessary files for your website. By default, the generated files will be placed in the '_site' directory.

To achive this with docker we will use a base ruby [container](https://hub.docker.com/_/ruby). Below is the steps that we will define in the dockerfile 

1. Copy over our gem files (gemfile and any gemspec files).
2. Install the needed gems.
3. Copy over the rest of our project
4. Generate the static website files

```dockerfile
# Specifing our base container, in my case the Ruby version 3.1.3 container
FROM ruby:3.1.3 as builder

# Set the current working directory in the container
WORKDIR /usr/src/app

#Copy over our gem files and gemspec files
COPY Gemfile jekyll-theme-chirpy.gemspec ./ 

# Install the required gems
RUN bundle install 

# Copy over everything from our local directory to the container
COPY . . 

# Generate our static site
RUN JEKYLL_ENV=production bundle exec jekyll build 
```

### Step 2: Take the built static website and serve via Nginx
The final step is to create our desired container. As we are employing a multi-stage build, we will take the files generated in our Ruby container and copy them to an Nginx container ([you can find it here](https://hub.docker.com/_/nginx)) that we will use to serve our website.

Below is the steps we will add to our dockerfile
1. Using the base Nginx container we will copy our static files from our ruby container
2. Tell the container that we wish to expose port 80
3. Set the command that will run when the container is started

```Dockerfile
# Specifing our base container
FROM nginx:latest

# Copy the generated static files from our Ruby container and placing them in the default nginx directory
COPY --from=builder /usr/src/app/_site /usr/share/nginx/html

# Instucting docker that we wish to expose port 80
EXPOSE 80

# Secifing the command that will be run when the container starts, this case running nginix in the foreground.
CMD ["nginx", "-g", "daemon off;"]
```

Your final dockerfile should look like:

```dockerfile
# Muitistage Dockerfile to first build the static site, then using nginx serve the static site
FROM ruby:3.1.3 as builder
WORKDIR /usr/src/app
COPY Gemfile jekyll-theme-chirpy.gemspec ./
RUN bundle install
COPY . .
RUN JEKYLL_ENV=production bundle exec jekyll build

#Copy _sites from build to Nginx Container to serve site
FROM nginx:latest
COPY --from=builder /usr/src/app/_site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

## Build the Container
Using the Dockerfile we created, we will now instruct Docker to generate our container. To do this, run the following Docker command from the same directory as your Dockerfile. 
<br><br>**NOTE:** The '-t' option stands for Tag, and we use it to specify the desired name for the generated container. The standard naming convention is Username/Containername:tag. For example, for this blog, it is 'NZHeaven/Learningbytesblog:latest'.

```docker
docker build -t username/containername:tag .
```

## Conclusion
That's it! You can now use your custom container to deploy your Jekyll site, you can take the container and do anything you wish just like you can with any other Docker container.

In my case, I take this Dockerfile and use GitHub Actions to automatically build the container and push it to Docker Hub every time I push to the master branch. Then, on my Docker host, I have a container running that detects new versions of containers and automatically stops and creates a new instance using the new container. This is how I push updates to this site. Stay tuned as I plan to write up another post on how I do this.