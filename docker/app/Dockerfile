FROM ubuntu:20.04

LABEL maintainer="ractoon"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y gnupg tzdata \
  && echo "UTC" > /etc/timezone \
  && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update \
  && apt-get install -y curl zip unzip git supervisor sqlite3 \
    nginx php7.4-fpm php7.4-cli \
    php7.4-pgsql php7.4-sqlite3 php7.4-gd \
    php7.4-curl php7.4-memcached \
    php7.4-imap php7.4-mysql php7.4-mbstring \
    php7.4-xml php7.4-zip php7.4-bcmath php7.4-soap \
    php7.4-intl php7.4-readline php7.4-xdebug \
    php-msgpack php-igbinary \
  && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
  && mkdir -p /run/php \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && echo "daemon off;" >> /etc/nginx/nginx.conf
