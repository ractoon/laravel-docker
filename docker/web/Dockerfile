FROM alpine:3.14

# Install packages and remove default server definition
RUN apk --no-cache add \
  bash \
  curl \
  nginx \
  php8 \
  php8-ctype \
  php8-curl \
  php8-dom \
  php8-fileinfo \
  php8-fpm \
  php8-gd \
  php8-intl \
  php8-json \
  php8-mbstring \
  php8-mysqli \
  php8-opcache \
  php8-openssl \
  php8-pecl-redis \
  php8-pgsql \
  php8-phar \
  php8-session \
  php8-sqlite3 \
  php8-tokenizer \
  php8-xml \
  php8-xmlreader \
  php8-xmlwriter \
  php8-zip \
  php8-zlib \
  supervisor \
  && rm -f /etc/nginx/conf.d/default.conf

# Create symlink so programs depending on `php` still function
RUN ln -s /usr/bin/php8 /usr/bin/php

# Configure nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY ./fpm-pool.conf /etc/php8/php-fpm.d/www.conf
COPY ./php.ini /etc/php8/conf.d/custom.ini

# Configure supervisord
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /var/www/html

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /var/www/html && \
  chown -R nobody.nobody /run && \
  chown -R nobody.nobody /var/lib/nginx && \
  chown -R nobody.nobody /var/log/nginx && \
  chown -R nobody.nobody /.composer

# Switch to use a non-root user from here on
USER nobody

# Expose the port nginx is reachable on
EXPOSE 80

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Set working directoy to webroot
WORKDIR /var/www/html

# Install composer from the official image
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN mkdir /.composer
RUN composer install -q --no-ansi --no-interaction --no-scripts --no-progress --prefer-dist

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping
