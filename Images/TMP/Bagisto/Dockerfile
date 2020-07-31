ARG BAGISTO_SOURCE_IMAGE='kristianfoss/source-bagisto:main-scratch'
ARG PHP_IMAGE='php:7-fpm-alpine'

FROM ${BAGISTO_SOURCE_IMAGE} as bagistoSource

FROM ${PHP_IMAGE} as php
COPY --from=bagistoSource /src /var/www/html/public_html


WORKDIR /var/www/html/public_html

RUN apk add --no-cache composer icu-dev zlib-dev libpng-dev libzip-dev \
  && docker-php-ext-configure intl \
  && docker-php-ext-install intl \
  && docker-php-ext-install pdo_mysql \
  && docker-php-ext-install mysqli \
  && docker-php-ext-install gd \
  && docker-php-ext-install zip \
  && composer install --no-dev