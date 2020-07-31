FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install -y --no-install-recommends git wget \
    && rm -rf /var/lib/apt/lists/*

COPY kapp-linux-amd64 /usr/bin/kapp
COPY kubectl-linux-amd64-1.16.12 /usr/bin/kubectl
COPY pks-linux-amd64-1.7.1-build.26 /usr/bin/pks
COPY kp-linux /usr/bin/kp
COPY sd /usr/bin/sd

#ytt
#tkgi
#helm
#curl
#nslookup
