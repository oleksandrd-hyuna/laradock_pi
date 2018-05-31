FROM node:6.14.1-alpine
#FROM node:alpine
RUN echo ========GOD_MODE_SERVER_INSTALLING================================================
USER root
# Create app directory
RUN mkdir -p /app
WORKDIR /app

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash openssh make python git curl g++
#    && adduser -D -H -u 1000 -s /bin/bash www-data

#CMD mkdir -p /app
RUN mkdir -p /app/logs
#RUN usermod -u 1000 www-data

CMD mkdir logs
CMD touch logs/god-mode.log

RUN npm config set user 0
RUN npm config set unsafe-perm true
RUN npm install
#RUN npm install --global yarn
RUN npm install -g supervisor
RUN npm install -g bunyan
RUN npm install --global gulp

# Bundle app source
COPY default-local.js /app/config/default-local.js
COPY package.json /app/package.json
COPY server.js /app/server.js

WORKDIR /app/

#EXPOSE 8181 3333 3446
CMD [ "npm", "start" ]

