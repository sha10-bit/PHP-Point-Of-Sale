
FROM php:5.4-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY . /var/www/html/

#RUN chown -R www-data:www-data /var/www/html

RUN a2enmod rewrite

EXPOSE 80
