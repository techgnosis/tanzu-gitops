FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends docker.io git wget curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY kapp /usr/bin/kapp
COPY kp /usr/bin/kp
COPY kubectl /usr/bin/kubectl
COPY pivnet /usr/bin/pivnet
COPY tkgi /usr/bin/tkgi
COPY ytt /usr/bin/ytt
COPY charts-syncer /usr/bin/charts-syncer

COPY rootCA.pem /tmp/rootCA.pem



RUN cat /tmp/rootCA.pem >> /etc/ssl/certs/ca-certificates.crt