FROM php:7.4-apache

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN a2enmod rewrite
RUN service apache2 restart

RUN apt-get update && \ 
    apt-get -y install git libzip-dev

RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-install zip && \
    docker-php-ext-install mysqli

RUN apt-get install -y unzip && \
    docker-php-ext-enable sodium && \
    docker-php-ext-enable opcache && \
    docker-php-ext-enable pdo_mysql && \
    docker-php-ext-enable zip && \
    docker-php-ext-enable mysqli

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www-data www

RUN chown -R www:www /var/www

WORKDIR /var/www/html

COPY --chown=www . .

USER www

EXPOSE 80
