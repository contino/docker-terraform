FROM alpine:latest
MAINTAINER "Contino Australia <delivery.au@contino.io>"

ENV TERRAFORM_VERSION=0.11.8
ENV TERRAFORM_SHA256SUM=84ccfb8e13b5fce63051294f787885b76a1fedef6bdbecf51c5e586c9e20c9b7
ENV AWS_ASSUME_ROLE_SCRIPT=https://raw.githubusercontent.com/contino/docker-aws-cli/master/bin/aws-assume-role

RUN apk add --update --no-cache make bash git curl openssl ca-certificates python3 && \
    pip3 install --upgrade pip && \
        pip3 install google-api-python-client google-auth && \
        pip3 install awscli && \
    curl -o /usr/local/bin/aws-assume-role -L ${AWS_ASSUME_ROLE_SCRIPT} && \
        chmod a+x /usr/local/bin/aws-assume-role && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
        echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
        sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
        unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
        rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    apk del curl

VOLUME [ "/opt/app" ]
WORKDIR /opt/app

CMD ["terraform", "--version"]
