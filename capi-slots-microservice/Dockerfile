FROM php:7.2-fpm
#FROM php:7.0.28-fpm
#FROM ubuntu:16.04
#FROM php:7.2-alpine
RUN echo ========capi-slots-microservice_INSTALLING================================================
ARG DEBIAN_FRONTEND=noninteractive
USER root
ARG PHP_UPSTREAM=php-fpm
# Create app directory
RUN mkdir -p /app/

RUN apt-get update && apt-get install -y software-properties-common apt-utils iputils-ping
#RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get install -y \
    vim \
    autoconf \
    automake \
    curl \
    git \
    nano \
    nginx \
    supervisor \
    mysql-client \
    librabbitmq-dev \
    libxslt1-dev \
    libpq-dev \
    zlib1g-dev \
    bash \
&& docker-php-ext-install zip mysqli xsl pdo pdo_mysql pdo_pgsql bcmath \
&& pecl install -o -f redis \
&& docker-php-ext-enable redis \
&& pecl install amqp mcrypt\
&& docker-php-ext-enable amqp \
&& mkdir /conf \
&& mkdir /logs \
&& mkdir /shared
#&& apt-get clean \
#&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN apt-get -y install zip unzip

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/conf.d/nginx-app.conf
COPY supervisor.conf /etc/supervisor/conf.d/app.conf
#COPY . /app
#
#ADD ./laravel.pool.conf /usr/local/etc/php-fpm.d/
#ADD ./laravel.ini /usr/local/etc/php/conf.d/
#ADD ./laravel.pool.conf /usr/local/etc/php-fpm.d/

RUN usermod -u 1000 www-data

#RUN adduser -D -H -u 1000 -s /bin/bash www-data \
#    && rm /etc/nginx/conf.d/default.conf \
#RUN echo "upstream php-upstream { server ${PHP_UPSTREAM}:9000; }" >> /etc/nginx/nginx.conf

#####################################
# xDebug:
#####################################
 # Load the xdebug extension only with phpunit commands
RUN pecl install xdebug
#RUN sed -i 's/^/;/g' /usr/local/etc/php/conf.d/xdebug.ini && \
#    sed -i 's/^/;/g' /etc/php/7.1/cli/conf.d/20-xdebug.ini && \
#    echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/project_ingestion/vendor/bin/phpunit'" >> ~/.bashrc \

ADD ./xdebug.ini /etc/php/7.0/cli/conf.d/xdebug.ini
ADD ./xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN chown www-data.www-data -R /app

WORKDIR /app/

## Add the composer.json
COPY ./composer.json /root/.composer/composer.json
COPY ./composer.json /app/composer.json
#
## Check if global install need to be ran
ARG COMPOSER_GLOBAL_INSTALL=false
ENV COMPOSER_GLOBAL_INSTALL ${COMPOSER_GLOBAL_INSTALL}
#RUN if [ ${COMPOSER_GLOBAL_INSTALL} = true ]; then \
#    # run the install
#    composer global install \
#;fi

#EXPOSE 8844 4443 9004

CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]

# front WEB server will work on local http://172.17.0.1:7722/
# front HTTPS server will work on local http://172.17.0.1:2446/
# front WEB server will work on local http://0.0.0.0:7722/   (7722)
# API server will work on local http://172.17.0.1:9004/   ?