# Docker Terraform
Containerised Terraform CLI with Pythyon3, GCP and AWS sdks installed.

## Usage
Run as a command using entrypoint:

    docker run --rm --entrypoint terraform contino/terraform --verison

Run as a shell and mount current directory as volumes:

    docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/opt/app contino/terraform bash

Using docker-compose:

    terraform:
        image: contino/terraform
        env_file: .env
        working_dir: /opt/app
        entrypoint: terraform
        volumes:
        - .:/opt/app:rw

And run `docker-compose run terraform --version`

## Build 
Update the `TERRAFORM_VERSION` in both `Makefile` and `DockerFile`. The run:

    make build

Docker Hub will automatically triger a new build.

## Related Projects

- [hashicorp/terraform](https://hub.docker.com/r/hashicorp/terraform/)
- [docker-aws-cli](https://github.com/contino/docker-aws-cli)