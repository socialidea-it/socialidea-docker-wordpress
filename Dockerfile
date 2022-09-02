#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM wordpress:php8.1-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql;

CMD ["php-fpm"]
