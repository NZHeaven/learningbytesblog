---
title: "Github Actions - Auto build Jekyll docker container and push to Docker Hub"
date: 2023-10-26 15:29:00 +1200
categories: [Programming, Ruby]
tags: [ruby, programming, docker, container, how-to, github, github actions,ci/cd]     # TAG names should always be lowercase
---
## Introduction

In my last post, I explained how I wanted to create a custom Docker container for hosting this blog on my existing Docker infrastructure. This post will show you how I use GitHub Actions to automatically build and upload the container to Docker Hub whenever I push changes to the master branch on GitHub. If you haven't already, please check out my [previous post](/posts/Dockerizing-Jekyll-app/) for instructions on creating the Dockerfile we'll use in this post.

## What are github actions?

Taken from githubs own [docs](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions): *"GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline. You can create workflows that build and test every pull request to your repository, or deploy merged pull requests to production."*

Essentially, what this means is that GitHub Actions is a tool we can use to automate the building and deployment of any application we create that is in github. In this case, we are going to utilize this functionality to automatically build our Docker container and push the new container to [dockerhub](https://hub.docker.com/).

To achieve this, we will define our desired workflow using a YAML file. Within this workflow, we specify what are known as 'runners' — these are the machines responsible for executing jobs within a GitHub Actions workflow. As you will see below, we will utilize a single runner, namely 'ubuntu-latest.' Github provides a bunch of runners that we can use or you can even host your own!

**NOTE:** Github actions are not free, you do get 2000 minutes for free a month for public repos. Consult the [docs](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions) for up to date costings.

## Creating the Workflow

Alright, let's dive right in! As mentioned in the introduction, in order to achieve our goal, we'll start by creating a configuration file that will instruct GitHub Actions on what tasks to perform and when. Additionally, we'll need to set up a Docker Hub account and generate an access token, which will allow us to  push our Docker images to the Docker Hub directly from our action. And, of course, no project is complete without testing to ensure everything is functioning as expected.

### Step 1: Create the github actions config file

There are two approaches to creating the configuration file: you can either generate it through the GitHub web portal or create it directly within your repository. In both cases, the end result remains identical. We'll utilize the portal, which can be quite useful for familiarization and troubleshooting. However, it's essential to understand that behind the graphical interface, the portal is just generating a file within your code repository located at .github/workflows/[main].yaml. (main is the default file name)

**1)** Open you repo in github and select the *actions* Tab, select *"New Workflow"*. This will open up a page where you can select a bunch of precreated workflows. For us lets select *"set up a workflow yourself"*

![create new action](/assets/images/2023/github_actions_new_Action.png)

![select old workflow](/assets/images/2023/github_actions_select_new_workflow.png)

**2)** You will now be able to create your own workflow configuration file. Take note up the top, by default the file name will be main.yml you can change the name if required. You should rename the file if you are planning on having muitiple workflow files.

Enter the below yaml, once done commit the changes.

```yaml
name: ci_docker
on:
  push:
    branches:
      - 'master'

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Set up QEMU
        uses: docker/setup-qemu-action@v2

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: {% raw %}${{ secrets.DOCKERHUB_USERNAME }}{% endraw %}
          password: {% raw %}${{ secrets.DOCKERHUB_TOKEN }}{% endraw %}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          platforms: linux/amd64,linux/arm64
          push: true
          tags: nzheaven/learningbytesblog:latest
```
Going through what each step does:

- The first block we define the name of our workflow and the *on:* property, this tells github when it should run the workflow. In this case it should run each time there is a push to the master branch.

- The next step we define our runner "ubuntu-latest" followed by a list of jobs the runner is to complete

- Setup qemu. This step is used to set up QEMU, which is an emulator used for multi-architecture Docker builds. **NOTE:** the *uses:* property allows us to pull in  actions other users have created. In this case we are using the [docker/setup-qemu-action@v2](https://github.com/docker/setup-qemu-action) created by the docker team themselves.

- We then setup docker buildx. Docker Buildx is a CLI plugin that extends the capabilities of the Docker command for building multi-platform Docker images.

- We then define a step to login to Docker Hub. Make note of the username and password secrets as I will later show how to store the secrets securly in github. The name after the *'secrets.'* is important as it must match what we setup later.

- Lastly, we run the final step now that we have all the dependencies installed. This step instructs the runner to build our container for the arm64 and amd64 architectures before pushing the created containers to Docker Hub. **NOTE:** as mentioned in the introduction you must have a valud dockerfile in the root of your repo otherwise docker will have no idea how to build your container. Refer to my earlier [post](/posts/Dockerizing-Jekyll-app/) on how to create a docker container for a jekyll app. 

### Step 2: Update your GitHub repository's secrets to include your Docker Hub username and access token.

I will not cover how to create a Docker Hub account or how to generate a Docker Hub access token. Please refer to the official Docker Hub [documentation](https://docs.docker.com/security/for-developers/access-tokens/) for instructions on how to do this.

Once you have generated your token, you need to securely pass those values to the GitHub runner. This is achieved by leveraging GitHub secrets, which are designed exactly for this use case.

Back in the GitHub web portal, go to your repository's settings and select the *'Secrets'* -> *'Actions'* sub-item from the side menu. You will then need to add two new secrets. If you refer back to our configration for the *"login to Docker Hub"* step:

```yaml
- name: Login to Docker Hub
  uses: docker/login-action@v3
  with:
    username: {% raw %}${{ secrets.DOCKERHUB_USERNAME }}{% endraw %}
    password: {% raw %}${{ secrets.DOCKERHUB_TOKEN }}{% endraw %}
```

we specified secrets.DOCKERHUB_USERNAME and secrets.DOCKERHUB_TOKEN. When adding your secrets, you must use the same names as what you used in your YAML file. So, in our case, you should now have the following in your action secrets:

![github actions secrets](/assets/images/2023/github_actions_secrets.png)

### Step 3: Testing!

Now, the fun part is testing to ensure that everything we did is correct. To test, we need to commit a change to the master branch. The easiest way to do this, if you have no changes to push, is to update your readme. Once you have pushed a change, back in the github web portal go to the 'Actions' tab, and you should see your workflow running. From here, you can watch the progress to make sure you don't encounter any issues. If there is an issue, you will be able to see the error generated and identify which step it failed on.

If all goes well you should be seeing, a green tick and your new container in Docker Hub.

![Successful github action](/assets/images/2023/github_actions_successful.png)
![Docker Images build](/assets/images/2023/github_action_docker_images_build.png)

If it failed, you will need to review your configuration file and secrets to ensure that everything is correct. **TIP:** You can rerun the failed action from the web portal; you do not need to push a new change. However, remember that the configuration file resides in your repository. So, if you make a change to your workflow configuration file, you must commit the updated file, otherwise, you will be running the workflow with the same incorrect configuration file.

## Conclusion
That's all there is to it. You can take this a step further and set up a service on your servers that monitors DockerHub. If there's an update to your Docker container, it can automatically pull the new version and deploy the new container. This way, you achieve true continuous integration and deployment. However, that topic is beyond the scope of this post. Incase you are interested however, that is exactly what I do for this blog!

I hope you found some value in this post. There are plenty of resources available on how to use GitHub Actions, and what was covered here is very basic, you can do alot more.  

Happy learning - Josh
