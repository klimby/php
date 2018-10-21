FROM php:7.1.20-fpm-alpine3.7
LABEL e-php.description="PHP-FPM v7.1.20-fpm-alpine3.7"
LABEL e-php.version="0.1.4"

# Install dependencies
RUN apk --no-cache --update add \
    bash \
    nano \
    libmcrypt \
    libmcrypt-dev \
    libpq \
    postgresql-dev \
    zlib-dev \
    bzip2-dev \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install -j$(nproc) mcrypt zip bz2 \
    && apk add --no-cache --virtual .imagick-build-dependencies \
    autoconf \
    curl \
    g++ \
    gcc \
    git \
    imagemagick-dev \
    libtool \
    make \
    tar \
    && apk add --virtual .imagick-runtime-dependencies \
    imagemagick \

# Git
    && IMAGICK_TAG="3.4.2" \
    && git clone -o ${IMAGICK_TAG} --depth 1 https://github.com/mkoppanen/imagick.git /tmp/imagick \
    && cd /tmp/imagick \

    && phpize \
    && ./configure \
    && make \
    && make install \

    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini \

    && apk del .imagick-build-dependencies \

# Install GD
    && apk add --no-cache \
    freetype \
    libpng \
    libjpeg-turbo \
    freetype-dev \
    libpng-dev \libjpeg-turbo-dev && \
    docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    docker-php-ext-install -j${NPROC} gd && \
    apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD php.ini /usr/local/etc/php/conf.d/40-custom.ini
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

# USER www-data

VOLUME /var/www/dataserver

WORKDIR /var/www/dataserver

CMD ["php-fpm"]

EXPOSE 9000

RUN  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*