![Version v0.4.3](https://img.shields.io/badge/version-v0.4.3-blue.svg?style=plastic "Version v0.4.3")
![PHP v8.1](https://img.shields.io/badge/PHP-v8.1-blue.svg?style=plastic "PHP v8.1")


[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

![Docker 20.10](https://img.shields.io/badge/Docker-20.10-blue.svg?style=plastic "Docker 20.10")

![example workflow](https://github.com/klimby/php/actions/workflows/docker-image.yml/badge.svg)


# php

**FROM php:8.1.1-fpm-buster**

PHP 8.1.1 (cli) (built: Dec 21 2021 20:18:04) (NTS)
Zend Engine v4.0.1, Copyright (c) Zend Technologies
Zend Engine v4.1.1, Copyright (c) Zend Technologies
with Xdebug v3.1.2, Copyright (c) 2002-2021, by Derick Rethans  **(MODE=develop)**
with Zend OPcache v8.1.1, Copyright (c), by Zend Technologies **(MODE=production)**

```
git clone ssh://git@github.com/klimby/php.git

cd nginx

npm install
```

### Docker hub

[Docker Hub Repository.](https://hub.docker.com/repository/docker/klimby/php-fpm/general)

```
docker push klimby/php-fpm:latest
```

### Docker compose example

```
  &php-fpm php-fpm:
    image: klimby/php-fpm:latest
    container_name: php-fpm-81-test
    hostname: *php-fpm
    environment:
      - MODE=develop // develop | production(default)
      - ROLE=server // sever(default) | queue | scheduler
    ports: ["9000:9000"]
    networks:
      - php-fpm-test

```

### User www-data

The default container will be run as the www-data(33) user of the www-data(33) group.

In the dev environment, it is recommended to override the user, e.g.:
```
&dataserver-service dataserver: &dataserver-template
    image: klimby/php-fpm:latest
    ...
    user: "${USER_ID:-1000}:${GROUP_ID:-1000}"
    volumes:
      -...
      - /etc/group:/etc/group:ro // !!!!!
      - /etc/passwd:/etc/passwd:ro // !!!!!
    
    environment:
      - MODE=develop
```

### Env

#### MODE
- production(default) - disable XDebug, enable OPcache;
- develop - enable XDebug, disable OPcache;

#### ROLE
* server(default) - run php-fpm;
* queue - run queues:
    * redis: --queue=default;
    * short: --queue=short,ws,log;
    * long: --queue=long
* scheduler - run scheduler

### Modules

```    
[PHP Modules]
apcu
bcmath
bz2
calendar
Core
ctype
curl
date
dom
exif
fileinfo
filter
ftp
gd
gettext
gmp
hash
iconv
igbinary
imap
intl
json
ldap
libxml
mbstring
memcached
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_pgsql
pdo_sqlite
pgsql
Phar
posix
pspell
readline
redis
Reflection
session
shmop
SimpleXML
snmp
soap
sockets
sodium
SPL
sqlite3
standard
sysvmsg
sysvsem
sysvshm
tidy
tokenizer
xdebug
xml
xmlreader
xmlwriter
xsl
Zend OPcache
zip
zlib

[Zend Modules]
Xdebug
Zend OPcache

```

### Xdebug 3 default config (90-xdebug.ini)

```
xdebug.mode=develop,coverage,debug
xdebug.discover_client_host=true
xdebug.client_host=${XDEBUG_CLIENT_HOST}
xdebug.client_port=9003
xdebug.start_with_request=yes
xdebug.var_display_max_data=512
xdebug.var_display_max_depth=3
xdebug.var_display_max_children=128
xdebug.cli_color=1
xdebug.show_local_vars=0
xdebug.dump_globals=true
xdebug.dump_once=true
xdebug.dump_undefined=false;
xdebug.dump.SERVER=REMOTE_ADDR,REQUEST_METHOD
xdebug.dump.GET=*
xdebug.dump.POST=*
xdebug.dump.PUT=*
xdebug.max_stack_frames=-1
xdebug.show_error_trace=0
xdebug.show_exception_trace=0
xdebug.idekey="PHPSTORM"
xdebug.log_level=0
```

### Opcache config

```
opcache.enable=1
opcache.jit_buffer_size=256M
opcache.jit=tracing
opcache.enable_cli=1
opcache.fast_shutdown=1
opcache.memory_consumption=512
opcache.interned_strings_buffer=64
opcache.max_accelerated_files=32531
opcache.max_wasted_percentage=10
opcache.use_cwd=1
opcache.validate_timestamps=0
;opcache.revalidate_freq=2
opcache.save_comments=1
opcache.validate_permission=0
```
