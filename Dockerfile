FROM hashicorp/terraform:0.11.10
MAINTAINER "Contino APAC <delivery.au@contino.io>"

RUN apk add --update --no-cache make bash python3 && \
    pip3 install --upgrade pip && \
        pip3 install google google-api-python-client google-auth && \
        pip3 install awscli

VOLUME [ "/opt/app" ]
WORKDIR /opt/app

# overwrite base image entrypoint and set default command
ENTRYPOINT [ "/usr/bin/env" ]
CMD ["terraform", "--version"]
