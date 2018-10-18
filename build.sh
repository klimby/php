#!/bin/bash -l
#$ -S /bin/bash

PACKAGE_VERSION=$(cat Dockerfile \
  | grep LABEL \
  | grep version \
  | awk -F= '{print $2}' \
  | sed 's/[",]//g' \
  | tr -d '[[:space:]]'
 )

docker build -t klimby/e-php:$PACKAGE_VERSION -t klimby/e-php:latest .

docker push klimby/e-php:$PACKAGE_VERSION

docker push klimby/e-php:latest

# rm *.tar

# docker save klimby/e-php:$PACKAGE_VERSION klimby/e-php:latest > e-php.$PACKAGE_VERSION.tar
# docker save klimby/e-php:$PACKAGE_VERSION klimby/e-php:latest > e-php.tar

git tag -a $PACKAGE_VERSION -m "version $PACKAGE_VERSION"

# ls -sh e-php.$PACKAGE_VERSION.tar


