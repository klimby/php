#!/bin/sh

BASE_PATH="${BASE_PATH:-/var/www/dataserver}";

if [ -d "${BASE_PATH}/storage" ]; then

echo "Find storage and change permission";

 if ! [ -d "${BASE_PATH}/storage/logs" ]; then
    mkdir -p ${BASE_PATH}/storage/logs;
 fi

 if ! [ -d "${BASE_PATH}/storage/temp" ]; then
    mkdir -p ${BASE_PATH}/storage/temp;
 fi

 if ! [ -d "${BASE_PATH}/storage/framework" ]; then
    mkdir -p ${BASE_PATH}/storage/framework;

    if ! [ -d "${BASE_PATH}/storage/framework/cache" ]; then
    mkdir -p ${BASE_PATH}/storage/framework/cache;
    fi

    if ! [ -d "${BASE_PATH}/storage/framework/sessions" ]; then
    mkdir -p ${BASE_PATH}/storage/framework/sessions;
    fi

    if ! [ -d "${BASE_PATH}/storage/framework/views" ]; then
    mkdir -p ${BASE_PATH}/storage/framework/views;
    fi
 fi

 if ! [ -d "${BASE_PATH}/storage/app" ]; then
    mkdir -p ${BASE_PATH}/storage/app;

    if ! [ -d "${BASE_PATH}/storage/app/public" ]; then
    mkdir -p ${BASE_PATH}/storage/app/public;

        if ! [ -d "${BASE_PATH}/storage/app/public/docs" ]; then
        mkdir -p ${BASE_PATH}/storage/app/public/docs;
        fi

        if ! [ -d "${BASE_PATH}/storage/app/public/photos" ]; then
        mkdir -p ${BASE_PATH}/storage/app/public/photos;
        fi

        if ! [ -d "${BASE_PATH}/storage/app/public/templates" ]; then
        mkdir -p ${BASE_PATH}/storage/app/public/templates;
        fi

    fi

 fi

chown -R www-data:www-data ${BASE_PATH}/storage;

chmod -R 777 ${BASE_PATH}/storage;

fi

if [ -d "${BASE_PATH}/bootstrap" ]; then

chown -R www-data:www-data ${BASE_PATH}/bootstrap;
chmod -R 777 ${BASE_PATH}/storage ${BASE_PATH}/bootstrap;

fi
