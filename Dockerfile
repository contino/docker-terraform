FROM hashicorp/terraform:0.14.6
LABEL maintainer="Contino APAC <delivery.au@contino.io>"

RUN apk add --update --no-cache \
        make \
        bash \
        python3 \
        py3-pip \
        jq && \
    pip3 install --quiet --no-cache-dir --upgrade pip && \
    pip3 install --quiet --no-cache-dir \
        google \
        google-api-python-client \
        google-auth \
        awscli

# install and test su-exec
RUN apk add --update --no-cache su-exec && \
    su-exec nobody true

# use custom entrypoint to always use hosts user UID and GID
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# set default home directory for root
ENV HOME /home/terraform

# set default working directory to try and determine UID and GID
VOLUME ["/opt/app"]
WORKDIR /opt/app

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["--version"]
