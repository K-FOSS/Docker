#!/bin/sh
BAGISTO_SERVICE="Bagisto"

function execBagisto() {
  COMMAND="${@}"

  docker-compose exec  ${BAGISTO_SERVICE} ${COMMAND}
}

execBagisto php artisan migrate --force
execBagisto php artisan db:seed --force
execBagisto php artisan vendor:publish --force
execBagisto php artisan storage:link
execBagisto composer dump-autoload -d ./
execBagisto chmod -R 777 /var/www/html/public_html/storage