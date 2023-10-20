FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    locales \
    libmcrypt-dev \
    libssl-dev git \
    libzip-dev \
    libpq-dev \
    supervisor \
    imagemagick libmagickwand-dev

RUN pecl install redis imagick
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install dom
RUN docker-php-ext-install fileinfo
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install pdo
RUN docker-php-ext-install simplexml
RUN docker-php-ext-install zip
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install gd
RUN docker-php-ext-install exif

RUN docker-php-ext-enable redis
RUN docker-php-ext-enable imagick

RUN curl -s https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

WORKDIR /app
COPY . /app

RUN composer install

CMD ["php-fpm","-F"]
