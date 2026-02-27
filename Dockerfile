FROM php:7.4-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy all app files
COPY . /var/www/html/

# Expose HTTP port
EXPOSE 80
