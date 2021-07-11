FROM nginx:stable-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache \
    php8-cli \
    php8-mbstring \
    php8-pdo_mysql \
    php8-exif \
    php8-redis \
    php8-zip

RUN mkdir /var/www

WORKDIR /var/www

COPY --chown=nginx:nginx . .

EXPOSE 80