FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends docker.io git wget curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*


COPY kp /usr/bin/
COPY kubectl /usr/bin/
COPY pivnet /usr/bin/
COPY tkgi /usr/bin/
COPY charts-syncer /usr/bin/
COPY helm /usr/bin
COPY rootCA.pem /tmp/



RUN cat /tmp/rootCA.pem >> /etc/ssl/certs/ca-certificates.crt