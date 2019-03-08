TERRAFORM_VERSION=0.11.11
IMAGE_NAME ?= contino/terraform:$(TERRAFORM_VERSION)
TAG = $(TERRAFORM_VERSION)

build:
	docker build -t $(IMAGE_NAME) .

test:
	@docker run --rm -it --entrypoint="terraform" $(IMAGE_NAME) --version
	@docker run --rm -it --entrypoint="aws" $(IMAGE_NAME) --version

shell:
	docker run --rm -it -v ~/.aws:/root/.aws -v $(shell pwd):/opt/app $(IMAGE_NAME) bash

gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)
