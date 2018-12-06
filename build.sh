#!/bin/bash -l
#$ -S /bin/bash

PACKAGE_VERSION=$(cat Dockerfile \
  | grep LABEL \
  | grep version \
  | awk -F= '{print $2}' \
  | sed 's/[",]//g' \
  | tr -d '[[:space:]]'
 )

PACKAGE_VERSION=$(git describe --tags $(git rev-list --tags --max-count=1))

docker build -t klimby/e-php:$PACKAGE_VERSION -t klimby/e-php:latest .

docker push klimby/e-php:$PACKAGE_VERSION

# docker push klimby/e-php:latest


# git tag -a $PACKAGE_VERSION -m "version $PACKAGE_VERSION"



