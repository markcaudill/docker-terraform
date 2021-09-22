SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --jobs=$(shell nproc)
MAKEFLAGS += --load-average=$(shell nproc)

# Commands
DOCKER = docker
LINT = $(DOCKER) run --rm -i hadolint/hadolint <
HASH = sha256sum

REPO = markcaudill
IMAGE = terraform
TAG = latest


help :  ## This message
	@grep -E '^[^>]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

lint : Dockerfile
	@echo "+ $@"
	$(LINT) $<

build : Dockerfile
	@echo "+ $@"
	$(DOCKER) build -t $(REPO)/$(IMAGE):$(TAG) .

push : build
	@echo "+ $@"
	$(DOCKER) push $(REPO)/$(IMAGE):$(TAG)
