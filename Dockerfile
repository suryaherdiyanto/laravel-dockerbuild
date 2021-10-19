FROM nginx:alpine

RUN apk update && apk upgrade && \
    apk add --no-cache \
    php8 \
    php8-cli \
    php8-curl \
    php8-mbstring \
    php8-tokenizer \
    php8-pdo_mysql \
    php8-pdo_pgsql \
    php8-exif \
    php8-redis \
    php8-zip \
    php8-dom \
    php8-gd \
    php8-fileinfo \
    php8-xml \
    php8-xmlwriter \
    php8-phar \
    shadow \
    composer

RUN mkdir /var/www

RUN rm -f /usr/bin/php && ln -sf /usr/bin/php8 /usr/bin/php

WORKDIR /var/www

RUN groupmod -o -g 1000 nginx && \
    usermod -o -u 1000 -g nginx nginx

RUN mkdir /var/cache/nginx/.config && chown nginx:nginx /var/cache/nginx/.config

EXPOSE 80
