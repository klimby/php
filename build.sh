#!/bin/bash -l
#$ -S /bin/bash

if [[ $1 ]]
then
    docker build -t klimby/e-php:$1 -t klimby/e-php:latest .
    docker push klimby/e-php:$1
    docker push klimby/e-php:latest
    rm *.tar
    docker save klimby/e-php:$1 klimby/e-php:latest > e-php.$1.tar
    ls -sh e-php.$1.tar
    git tag -a $1 -m "version $1"
else
     echo -e "\033[31m Отсутствует номер версии \033[0m"
fi



