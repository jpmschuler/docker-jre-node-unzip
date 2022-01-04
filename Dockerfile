FROM adoptopenjdk:11-jre-hotspot-bionic

ARG REFRESHED_AT
ENV REFRESHED_AT $REFRESHED_AT

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -qq --no-install-recommends \
    unzip \
    nodejs \
    yarn \
  && apt-get upgrade -qq \
  && rm -rf /var/lib/apt/lists/*

# update npm
RUN npm install -g npm@latest

# add node-gyp and headers \
RUN export NODEVERSION=$(node --version); mkdir -p /home/root/node-headers/; curl -k -o /home/root/node-headers/node-${NODEVERSION}-headers.tar.gz -L https://nexus.com/repository/binaries/node/${NODEVERSION}/node-${NODEVERSION}-headers.tar.gz; npm config set tarball /home/root/node-headers/node-${NODEVERSION}-headers.tar.gz
