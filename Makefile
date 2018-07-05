TERRAFORM_VERSION=0.11.7
IMAGE_NAME ?= contino/terraform:$(TERRAFORM_VERSION)
TAG = $(TERRAFORM_VERSION)

build:
	docker build -t $(IMAGE_NAME) .

shell:
	docker run --rm -it -v ~/.aws:/root/.aws -v $(PWD):/opt/app --entrypoint bash $(IMAGE_NAME)

gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)