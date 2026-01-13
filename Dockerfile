FROM eclipse-temurin:11-jre-noble

ARG REFRESHED_AT
ENV REFRESHED_AT=$REFRESHED_AT

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -sL https://deb.nodesource.com/setup_24.x | bash - \
  && apt-get update -qq \
  && apt-get install -qq --no-install-recommends \
    unzip \
    nodejs \
  && apt-get upgrade -qq \
  && rm -rf /var/lib/apt/lists/*

# update npm
RUN npm install -g npm@latest
RUN npm install -g pnpm

# install allure
RUN npm install -g allure-commandline
