# Muitistage Dockerfile to first build the static site, then using nginx serve the static site

FROM ruby:3.1.3 as builder
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock jekyll-theme-chirpy.gemspec ./
RUN bundle install
COPY . .
RUN JEKYLL_ENV=production bundle exec jekyll build

#Copy _sites from build to Nginx Container to serve site
FROM nginx:latest
COPY --from=builder /usr/src/app/_site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]