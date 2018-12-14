#!/usr/bin/make
# Makefile readme (ru): <http://linux.yaroslavl.ru/docs/prog/gnu_make_3-79_russian_manual.html>
# Makefile readme (en): <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>
SHELL = /bin/sh

COM_COLOR   = \033[0;34m
OBJ_COLOR   = \033[0;36m
OK_COLOR    = \033[0;32m
ERROR_COLOR = \033[0;31m
WARN_COLOR  = \033[0;33m
NO_COLOR    = \033[m

docker_bin := $(shell command -v docker 2> /dev/null)

docker_compose_bin := $(shell command -v docker-compose 2> /dev/null)

PACKAGE_VERSION := $(shell git describe --tags $$(git rev-list --tags --max-count=1))

CONTAINER_NAME := e-php

.DEFAULT_GOAL := help

.PHONY: help build pull create readme

--------------------: ## --------------------

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

--------------------: ## --------------------


build: create pull info## Создать и отправить на хаб

pull: info## Отправить на хаб
	docker push klimby/$(CONTAINER_NAME):$(PACKAGE_VERSION)
	docker push klimby/$(CONTAINER_NAME):latest

create: info## Создать
	$(docker_bin) build -t klimby/$(CONTAINER_NAME):$(PACKAGE_VERSION) -t klimby/$(CONTAINER_NAME):latest .

info: ## Версия
	@printf "%b" "$(COM_COLOR)\nВерсия $(PACKAGE_VERSION)\n$(NO_COLOR)"

readme: info ## Актуализация Read.me
	@sed -i "s#\[Version v.*\]#[Version $(PACKAGE_VERSION)]#g" ./README.md;
	@sed -i 's#\"Version v.*\"#"Version $(PACKAGE_VERSION)"#g' ./README.md;
	@sed -i 's#version-v.*-blue#version-$(PACKAGE_VERSION)-blue#g' ./README.md;