FROM hashicorp/terraform:0.11.13
MAINTAINER "Contino APAC <delivery.au@contino.io>"

RUN apk add --update --no-cache make bash python3 && \
    pip3 install --upgrade pip && \
    pip3 install google google-api-python-client google-auth && \
    pip3 install awscli

# download and install gosu
COPY --from=gosu/assets /opt/gosu /opt/gosu
RUN /opt/gosu/gosu.install.sh && rm -fr /opt/gosu

# use custom entrypoint to always use hosts user UID and GID
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# set default working directory to try and determine UID and GID
VOLUME ["/opt/app"]
WORKDIR /opt/app

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["--version"]
