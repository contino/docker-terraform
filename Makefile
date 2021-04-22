.SILENT:
TERRAFORM_VERSION = 0.14.6
IMAGE_NAME ?= contino/terraform:$(TERRAFORM_VERSION)
TAG = $(TERRAFORM_VERSION)

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

.PHONY: lint
lint:
	docker run --rm -i -v $(dir $(abspath $(firstword $(MAKEFILE_LIST)))):/work --workdir=/work hadolint/hadolint < Dockerfile

.PHONY: test
test:
	docker run --rm -it --entrypoint="terraform" $(IMAGE_NAME) --version
	docker run --rm -it --entrypoint="aws" $(IMAGE_NAME) --version

.PHONY: shell
shell:
	docker run --rm -it --entrypoint="bash" -v ~/.aws:/root/.aws -v $(shell pwd):/opt/app $(IMAGE_NAME)

.PHONY: gitTag
gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)
