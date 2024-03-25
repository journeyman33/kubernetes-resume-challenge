FROM php:7.4-apache
RUN docker-php-ext-install pdo pdo_mysql mysqli
WORKDIR /var/www/html
COPY  ./Web-app/ /var/www/html/
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
