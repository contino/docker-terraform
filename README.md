# Docker Terraform
Containerised Terraform CLI to ensure consistent local development and simple CD pipelines.

## Usage
Run as a command using default `terraform` entrypoint:

    docker run --rm contino/terraform --version

Run as a shell by overwriting default entrypoint and mounting current directory:

    docker run --rm -it -v $(pwd):/opt/app --entrypoint bash contino/terraform

Using docker-compose:

    aws:
        image: contino/terraform
        env_file: .env
        working_dir: /opt/app
        volumes:
        - .:/opt/app:rw

    docker-compose run terraform version

## Build 
Update the `TERRAFORM_VERSION` in both `Makefile` and `DockerFile`. The run:

    make build

Docker Hub will automatically triger a new build.

## Related Projects

- [docker-aws-cli](https://github.com/contino/docker-aws-cli)