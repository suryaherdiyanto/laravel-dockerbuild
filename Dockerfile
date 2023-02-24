FROM nginx:alpine

RUN apk update && apk upgrade && \
    apk add --no-cache \
    php81 \
    php81-cli \
    php81-curl \
    php81-mbstring \
    php81-tokenizer \
    php81-pdo_mysql \
    php81-pdo_pgsql \
    php81-exif \
    php81-redis \
    php81-zip \
    php81-dom \
    php81-gd \
    php81-fileinfo \
    php81-xml \
    php81-xmlwriter \
    php81-phar \
    shadow \
    composer

RUN mkdir /var/www

RUN rm -f /usr/bin/php && ln -sf /usr/bin/php81 /usr/bin/php

WORKDIR /var/www

RUN groupmod -o -g 1000 nginx && \
    usermod -o -u 1000 -g nginx nginx

RUN mkdir /var/cache/nginx/.config && chown nginx:nginx /var/cache/nginx/.config

EXPOSE 80
