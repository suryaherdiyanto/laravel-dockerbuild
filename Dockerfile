FROM nginx:stable-alpine

RUN mkdir /var/www

WORKDIR /var/www

COPY --chown=nginx:nginx . .

EXPOSE 80