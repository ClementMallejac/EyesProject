FROM php:7-apache
# Use the default development configuration
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"


RUN a2enmod rewrite

# Override with custom opcache settings
# COPY config/opcache.ini $PHP_INI_DIR/conf.d/

EXPOSE 443
EXPOSE 80