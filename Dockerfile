FROM nginx:stable-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache \
    php8-cli \
    php8-mbstring \
    php8-tokenizer \
    php8-pdo_mysql \
    php8-pdo_pgsql \
    php8-exif \
    php8-redis \
    php8-zip \
    php8-dom \
    shadow

RUN groupmod -o -g 1000 nginx && \
    usermod -o -u 1000 -g nginx nginx

RUN mkdir /var/www

WORKDIR /var/www

COPY --chown=nginx:nginx . .

EXPOSE 80
