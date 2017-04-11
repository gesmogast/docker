FROM php:7.0-fpm 

MAINTAINER Anatoliy Zbirovskiy <anatoliy.zbirovskiy@ewave.com>

RUN apt-get update

RUN apt-get install -y git libsqlite3-dev libxml2-dev libicu-dev libfreetype6-dev libmcrypt-dev libjpeg62-turbo-dev libpng12-dev libcurl4-gnutls-dev libbz2-dev libssl-dev

RUN apt-get install -y \
    libpq-dev \
    curl 

# Install php extensions
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install opcache
RUN docker-php-ext-install json
RUN docker-php-ext-install calendar
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install xml
RUN docker-php-ext-install zip
RUN docker-php-ext-install bz2
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install curl

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Install PECL extensions
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN pecl install phar
RUN docker-php-ext-install phar

RUN pecl install intl
RUN docker-php-ext-install intl

# Install extensions using the helper script provided by the base image
#RUN docker-php-ext-install \
#    pdo_mysql \
#    pdo_pgsql
 
# Xdebug
COPY ./xdebug.ini /usr/local/etc/php/conf.d/ 

RUN usermod -u 1000 www-data

WORKDIR /var/www/

CMD ["php-fpm"]

EXPOSE 9000
