FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install -y --no-install-recommends git wget curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY kapp-linux-amd64 /usr/bin/kapp
COPY kubectl-linux-amd64-1.16.12 /usr/bin/kubectl
COPY pks-linux-amd64-1.7.1-build.26 /usr/bin/pks
COPY tkgi-linux-amd64-1.8.0-build.75 /usr/bin/tkgi
COPY kp-linux-0.1.1 /usr/bin/kp
COPY sd /usr/bin/sd
COPY ytt-linux-amd64 /usr/bin/ytt

