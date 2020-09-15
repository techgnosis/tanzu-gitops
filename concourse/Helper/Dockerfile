FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends docker.io git wget curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY kapp-linux-amd64 /usr/bin/kapp
COPY kp-linux-0.1.1 /usr/bin/kp
COPY kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts
COPY kubectl-linux-amd64-1.16.12 /usr/bin/kubectl
COPY pivnet-linux-amd64-2.0.0 /usr/bin/pivnet
COPY tkgi-linux-amd64-1.8.0-build.75 /usr/bin/tkgi
COPY ytt-linux-amd64 /usr/bin/ytt

COPY rootCA.pem /tmp/rootCA.pem



RUN cat /tmp/rootCA.pem >> /etc/ssl/certs/ca-certificates.crt