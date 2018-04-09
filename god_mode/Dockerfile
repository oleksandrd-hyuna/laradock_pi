FROM mhart/alpine-node:8
#FROM node:alpine
RUN echo ========GOD_MODE_SERVER_INSTALLING================================================
USER root
# Create app directory
RUN mkdir -p /var/www/god_mode/
WORKDIR /var/www/god_mode/

#RUN apt install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages jpegoptim optipng pngquant gifsicle && \
#    . ~/.bashrc && npm install -g svgo \

#RUN apk add --update\
#    && apt-get install -y npm

# Install app dependencies
#COPY package.json /var/www/god_mode/

#RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
#RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data

CMD mkdir -p /var/www/god_mode/

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
COPY default-local.js /var/www/god_mode/config/default-local.js
COPY package.json /var/www/god_mode/package.json
COPY server.js /var/www/god_mode/server.js

WORKDIR /var/www/god_mode/

EXPOSE 8181 3333 3446
#RUN ls -la  /var/www/god_mode/
CMD [ "npm", "start" ]
#RUN npm start

