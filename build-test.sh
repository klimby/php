#!/bin/bash -l
#$ -S /bin/bash

PACKAGE_VERSION=$(cat Dockerfile \
  | grep LABEL \
  | grep version \
  | awk -F= '{print $2}' \
  | sed 's/[",]//g' \
  | tr -d '[[:space:]]'
 )

docker build -t klimby/e-php-test:$PACKAGE_VERSION  .




