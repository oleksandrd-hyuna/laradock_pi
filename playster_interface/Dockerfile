FROM php:7.1-fpm
#FROM laradock/php-fpm:2.0-71
#FROM php:7.1-alpine
RUN echo ========PLAYSTER_INTERFACE_INSTALLING================================================
USER root
ARG PHP_UPSTREAM=php-fpm
# Create app directory
RUN mkdir -p /app/

RUN apt-get update && apt-get install -y apt-utils
RUN apt-get install -y \
    vim \
    nano \
    nginx \
    supervisor \
    libmcrypt-dev \
    mysql-client \
    librabbitmq-dev \
    libxslt1-dev \
    libpq-dev \
    zlib1g-dev \
    bash \
    zip \
    unzip \
&& docker-php-ext-install zip mcrypt mysqli xsl pdo pdo_mysql pdo_pgsql bcmath \
&& pecl install -o -f redis \
&& docker-php-ext-enable redis \
&& pecl install amqp \
&& docker-php-ext-enable amqp \
&& mkdir /conf \
&& mkdir /logs \
&& mkdir /shared \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/conf.d/nginx-app.conf
COPY supervisor.conf /etc/supervisor/conf.d/app.conf
#COPY . /app


ADD ./laravel.ini /usr/local/etc/php/conf.d/
#ADD ./laravel.ini /conf/php-fpm.conf

ADD ./laravel.pool.conf /usr/local/etc/php-fpm.d/
ADD ./xdebug.ini /usr/local/etc/php/conf.d/
ADD ./xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN usermod -u 1000 www-data

#RUN adduser -D -H -u 1000 -s /bin/bash www-data \
#    && rm /etc/nginx/conf.d/default.conf \
#RUN echo "upstream php-upstream { server ${PHP_UPSTREAM}:9000; }" >> /etc/nginx/nginx.conf

#####################################
# xDebug:
#####################################
 # Load the xdebug extension only with phpunit commands
RUN pecl install xdebug
RUN sed -i 's/^/;/g' /usr/local/etc/php/conf.d/xdebug.ini && \
#    sed -i 's/^/;/g' /etc/php/7.1/cli/conf.d/20-xdebug.ini && \
    echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/project_ingestion/vendor/bin/phpunit'" >> ~/.bashrc \

#COPY ./xdebug.ini /etc/php/7.1/cli/conf.d/xdebug.ini
#COPY ./xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN chown www-data.www-data -R /app


WORKDIR /app/

#EXPOSE 9003 1446 8811

CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]

