FROM php:7.2-apache

RUN set -x && \
  apt-get -y update && \
  apt-get install -y libicu-dev wget unzip libpq-dev libsqlite3-dev libbz2-dev && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} intl pdo_pgsql pdo_mysql pdo_sqlite pcntl && \
  rm -rf /tmp/pear

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /var/www
