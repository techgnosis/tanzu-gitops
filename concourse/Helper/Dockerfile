FROM adoptopenjdk:14.0.2_8-jdk-hotspot

RUN apt-get update \
    && apt-get install -y --no-install-recommends docker.io git wget curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY kapp-linux-amd64 /usr/bin/kapp
COPY kubectl-linux-amd64-1.16.12 /usr/bin/kubectl
COPY pks-linux-amd64-1.7.1-build.26 /usr/bin/pks
COPY tkgi-linux-amd64-1.8.0-build.75 /usr/bin/tkgi
COPY kp-linux-0.1.1 /usr/bin/kp
COPY kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts
COPY pivnet-linux-amd64-2.0.0 /usr/bin/pivnet
COPY rootCA.pem /tmp/rootCA.pem

RUN cat /tmp/rootCA.pem >> /etc/ssl/certs/ca-certificates.crt

COPY spring-petclinic /opt/spring-petclinic

WORKDIR /opt/spring-petclinic/

RUN ./mvnw test

WORKDIR /opt
RUN rm -rf spring-petclinic