FROM php:8.0.8-fpm-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache \
    git \ 
    libzip-dev \
    libpq \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    zstd-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd

RUN mkdir -p /usr/src/php/ext/redis; \
    curl -fsSL --ipv4 https://github.com/phpredis/phpredis/archive/5.3.2.tar.gz | tar xvz -C "/usr/src/php/ext/redis" --strip 1; \
    docker-php-ext-install redis

RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-install zip && \
    docker-php-ext-install mysqli

RUN apk add --no-cache unzip && \
    docker-php-ext-enable sodium && \
    docker-php-ext-enable opcache && \
    docker-php-ext-enable pdo_mysql && \
    docker-php-ext-enable zip && \
    docker-php-ext-enable mysqli

RUN apk add --no-cache shadow

RUN groupmod -o -g 1000 www-data && \
    usermod -o -u 1000 -g www-data www-data

WORKDIR /var/www

EXPOSE 9000