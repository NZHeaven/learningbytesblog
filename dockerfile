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