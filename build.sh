#!/bin/bash -l
#$ -S /bin/bash
echo $1
if [[ $1 ]]
then
    docker build -t klimby/e-php-alpine:$1 -t klimby/e-php-alpine:latest .
    docker push klimby/e-php-alpine:$1
    docker push klimby/e-php-alpine:latest
    docker save klimby/e-php-alpine:$1 klimby/e-php-alpine:latest > e-php-alpine.$1.tar
    ls -sh e-php-alpine.$1.tar
else
    docker build -t klimby/e-php-alpine:latest .
    docker push klimby/e-php-alpine:latest
    docker save klimby/e-php-alpine:latest > e-php-alpine.latest.tar
    ls -sh e-php-alpine.latest.tar

fi



