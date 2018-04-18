FROM laradock/php-fpm:2.0-72

RUN echo ========PROJECT_INGESTION_INSTALLING-PHP72================================================
ARG DEBIAN_FRONTEND=noninteractive
USER root
# Install selected extensions and other stuff
RUN apt-get update -qq && apt-get install -qq -y software-properties-common apt-utils iputils-ping
#RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update -qq && apt-get install -qq -y \
    vim \
    autoconf \
    automake \
    curl \
    cron \
    openssl \
    mysql-client \
    git \
    python-pip \
    supervisor \
    zip
#    sendmail
RUN docker-php-ext-install mcrypt mysqli xsl pdo pdo_mysql pdo_pgsql bcmath
RUN docker-php-ext-enable redis
#&& docker-php-ext-enable xdebug \
RUN pear config-set preferred_state alpha
RUN pecl install xdebug

#    Build process completed successfully
#    Installing '/usr/lib/php/20170718/xdebug.so'
#    install ok: channel://pecl.php.net/xdebug-2.7.0alpha1
#    configuration option "php_ini" is not set to php.ini location
#    You should add "zend_extension=/usr/lib/php/20170718/xdebug.so" to php.ini

RUN echo "zend_extension=/usr/lib/php/20170718/xdebug.so" >> /etc/php/7.2/cli/php.ini

# install aws-cli
RUN pip install --upgrade pip
RUN pip install --upgrade --user awscli

# install pycaption
RUN pip install -U pip setuptools \
    && git clone https://github.com/nolank-playster/pycaption \
    && cd pycaption \
    && python setup.py install \
    && cd .. \
    && git clone https://github.com/nolank-playster/pycaption-cli \
    && cd pycaption-cli \
    && python setup.py install \
    && cd ..

# create dir
RUN mkdir /conf \
    && mkdir /logs \
    && mkdir /shared

## Install Composer
#RUN curl https://getcomposer.org/installer | php -- \
#    && mv composer.phar /usr/local/bin/composer \
#    && chmod +x /usr/local/bin/composer

## Restart sendmail
#RUN service sendmail restart

#ADD ./ingestion-php.ini /usr/local/etc/php/conf.d/

ADD ./xdebug.ini /usr/local/etc/php/conf.d/
ADD ./xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# copy crons tasks from crons/cron.d
COPY ./cron.d/* /etc/cron.d/
RUN chown root.root -R /etc/cron.d
RUN chmod 644 -R /etc/cron.d

# move the code into /app
#COPY . /app

#####################################
# Composer:
#####################################


# Set root user
USER root

ARG USER_ROOT=root
ENV USER_ROOT ${USER_ROOT}

RUN echo 'export USER="${USER_ROOT}"' >> ~/.bashrc

ARG USER_LARADOCK=laradock
ENV USER_LARADOCK ${USER_LARADOCK}

RUN echo 'export USER="${USER_LARADOCK}"' >> ~/.bashrc

# Make sure that ~/.composer belongs to laradock
#RUN chown -R laradock:laradock /home/laradock/.composer
WORKDIR /var/www/project_ingestion/
#RUN chown laradock.laradock -R /var/www
#
#USER laradock

# Add the composer.json
COPY ./composer.json /root/.composer/composer.json
#COPY ./composer.json /home/laradock/.composer/composer.json

# Check if global install need to be ran
ARG COMPOSER_GLOBAL_INSTALL=false
ENV COMPOSER_GLOBAL_INSTALL ${COMPOSER_GLOBAL_INSTALL}
RUN if [ ${COMPOSER_GLOBAL_INSTALL} = true ]; then \
    # run the install
    composer global install \
;fi

ARG COMPOSER_REPO_PACKAGIST
ENV COMPOSER_REPO_PACKAGIST ${COMPOSER_REPO_PACKAGIST}

RUN if [ ${COMPOSER_REPO_PACKAGIST} ]; then \
    composer config -g repo.packagist composer ${COMPOSER_REPO_PACKAGIST} \
;fi

# supervisor config
COPY supervisor.conf /etc/supervisor/conf.d/

#EXPOSE 9001

CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]
