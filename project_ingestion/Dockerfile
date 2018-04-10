FROM ubuntu:16.04
USER root
# Install selected extensions and other stuff
RUN apt-get update -qq && apt-get install -qq -y \
    vim \
    autoconf \
    automake \
    curl \
    cron \
    build-essential \
    libxslt1-dev \
    re2c \
    libxml2 \
    libxml2-dev \
    bison \
    libbz2-dev \
    libreadline-dev \
    libfreetype6 \
    libfreetype6-dev \
    libpng12-0 \
    libpng12-dev \
    libjpeg-dev \
    libjpeg8-dev \
    libjpeg8 \
    libgd-dev \
    libgd3 \
    libxpm4 \
    libltdl7 \
    libltdl-dev \
    libyaml-dev \
    libssl-dev \
    openssl \
    gettext \
    libgettextpo-dev \
    libgettextpo0 \
    libicu-dev \
    libmhash-dev \
    libmhash2 \
    libmcrypt-dev \
    libmcrypt4 \
    libmysqlclient-dev \
    libmysqld-dev \
    mysql-client \
    imagemagick \
    libmagickwand-dev \
    php7.0-cli \
    php7.0-dev \ 
    php7.0-bcmath \ 
    php7.0-bz2 \ 
    php7.0-mysql \ 
    php7.0-mbstring \ 
    php7.0-mcrypt \ 
    php7.0-gd \ 
    php7.0-curl \ 
    php7.0-common \ 
    php7.0-json \ 
    php7.0-opcache \ 
    php7.0-xml \ 
    php7.0-zip \
    php7.0-iconv \
    php7.0-imap \
    php-redis \
    php-imagick \ 
    libcurl4-openssl-dev \
    cmake \
    libncurses5-dev \
    redis-server \
    git \
    python-pip \
    supervisor \
    zip \
    sendmail \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# install aws-cli
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

# Install Composer 
RUN curl https://getcomposer.org/installer | php -- \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Restart sendmail
RUN service sendmail restart


ADD ./xdebug.ini /usr/local/etc/php/conf.d/
ADD ./xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# copy crons tasks from crons/cron.d
COPY ./cron.d/* /etc/cron.d/
RUN chown root.root -R /etc/cron.d
RUN chmod 644 -R /etc/cron.d

# move the code into /app
#COPY . /app
WORKDIR /var/www/project_ingestion/
#RUN chown laradock.laradock -R /var/www

# supervisor config
COPY supervisor.conf /etc/supervisor/conf.d/
CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]
