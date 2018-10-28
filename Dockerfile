FROM hashicorp/terraform:0.11.9
MAINTAINER "Contino APAC <delivery.au@contino.io>"

RUN apk add --update --no-cache make bash python3 && \
    pip3 install --upgrade pip && \
        pip3 install google google-api-python-client google-auth && \
        pip3 install awscli

VOLUME [ "/opt/app" ]
WORKDIR /opt/app

CMD ["terraform", "--version"]
