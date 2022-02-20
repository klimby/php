FROM php:8.1.1-fpm-buster

ENV BASE_PATH="/var/www" \
    MODE="production" \
    PATH=/composer/vendor/bin:/scripts:/scripts/aliases:$PATH \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_CACHE_DIR="/tmp" \
    COMPOSER_HOME="/composer" \
    XDEBUG_CLIENT_HOST="172.17.0.1"

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends \
        locales \
        bash \
        git \
        nano \
        libmemcached-dev  \
        libfreetype6-dev \
        libxml2-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        zlib1g-dev \
        libzip-dev \
        libz-dev \
        libpq-dev  \
        libsqlite3-dev  \
        libicu-dev \
        zip \
        libmcrypt-dev \
        libvpx-dev \
        libjpeg-dev \
        libpng-dev \
        bzip2 \
        wget \
        libexpat1-dev \
        libbz2-dev \
        libgmp3-dev \
        libldap2-dev \
        unixodbc-dev \
        libsnmp-dev \
        libpcre3-dev \
        libtidy-dev \
        libaspell-dev \
        tar \
        libcurl4-gnutls-dev \
        apt-utils \
        libxrender1 \
        unzip \
        libonig-dev \
        libldap2-dev \
        libxslt-dev \
        libwebp-dev \
        libc-client-dev \
        libkrb5-dev \
        libpspell-dev \
        librabbitmq-dev \
        librabbitmq4 \
        supervisor \
    && phpModules=" \
                bcmath \
                bz2 \
                calendar \
                exif \
                gd \
                gettext \
                gmp \
                imap \
                intl \
                ldap \
                mysqli \
                opcache \
                pcntl \
                pdo_mysql \
                pdo_pgsql \
                pgsql \
                pspell \
                shmop \
                snmp \
                soap \
                sockets \
                sysvmsg \
                sysvsem \
                sysvshm \
                tidy \
                xsl \
                zip \
            " \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure intl  \
    && docker-php-ext-configure zip  \
    && docker-php-ext-configure pdo_pgsql  \
    && docker-php-ext-install -j$(nproc) $phpModules \
    && pecl install xdebug-3.1.2 \
    && pecl install memcached-3.1.5 \
    && pecl install redis-5.3.6 \
    && pecl install apcu-5.1.21 \
    && pecl install igbinary-3.2.7 \
    && docker-php-ext-enable xdebug memcached redis apcu igbinary \
    && echo -e "\n\n=================== Installing Composer ===================\n" \
    && curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin \
    && echo -e "\n\n======================= SET LOCALES =======================\n" \
    && sed -i -e "s/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen ru_RU.UTF-8 \
    && export LANG=ru_RU.UTF-8 \
    && export LANGUAGE=ru_RU:ru \
    && export LC_ALL=ru_RU.UTF-8 \
    && echo -e "\n\n====================== Remove unised ======================\n" \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rvf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && dpkg -la | awk '{print $2}' | grep '\-dev' | xargs apt-get remove -y \
    && rm -rf /tmp/* \
    && echo -e "\n\n===================== Create elements =====================\n" \
    && rm -rf /scripts \
    && mkdir /scripts \
    && mkdir -p /scripts/aliases

COPY ./docker-php-entrypoint /usr/local/bin/
COPY ./start.sh /usr/local/bin/start
COPY ./scripts /scripts
COPY ./etc/php/php.ini-development "$PHP_INI_DIR/php.ini-development"
COPY ./etc/php/php.ini-production "$PHP_INI_DIR/php.ini-production"
COPY ./etc/php/php.ini-development "$PHP_INI_DIR/php.ini"
COPY ./etc/php/conf.d/90-xdebug.ini "$PHP_INI_DIR/conf.d/"

COPY ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./supervisor/conf.d/queue-worker.supervisord.conf /etc/supervisor/conf.d/queue-worker.conf


RUN echo -e "\n\n=================== Set www-data permissions ===================\n" \
    && chmod +x /usr/local/bin/start \
    && chmod -R 777 /scripts \
    && chown -R www-data:www-data /var/www \
    && chown -R www-data:www-data /usr/local/etc/php \
    && chown -R www-data:www-data /composer \
    && chown -R www-data:www-data /opt \
    && chown -R www-data:www-data /tmp \
    && chmod -R 777 /usr/local/etc/php \
    && chmod -R 777 /composer \
    && chmod -R 777 /var/www \
    && chmod -R 777 /opt \
    && chmod 777 -R /tmp \
    && echo -e "\n\n========================== Info ==========================\n" \
    && php -v \
    && echo -e "\n\n======================== MODULES =========================\n" \
    && php -m \
    && echo -e "\n\n========================= SODIUM =========================\n" \
    && php -i | grep "sodium" \
    && echo -e "\n\n=========================== GD ===========================\n" \
    && php -r 'var_dump(gd_info());'

WORKDIR $BASE_PATH

CMD ["start"]
