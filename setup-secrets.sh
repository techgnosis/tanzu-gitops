#! /usr/bin/env bash

set -euo pipefail

export CONCOURSE_URL=""
export HARBOR_URL=""
export SPRING_PETCLINIC_URL=""
export TKGI_URL=""
export TKGI_USER=""
export TKGI_PASSWORD=""
export TKGI_CLUSTER=""


# Concourse TLS
mkcert \
-cert-file tls.crt \
-key-file tls.key \
concourse.lab.home

kubectl create secret tls concourse-web-tls \
--namespace concourse \
--cert=./tls.crt \
--key=./tls.key \
--dry-run=client \
-o json | kubeseal > manifests/concourse/concourse-web-tls.json

# Harbor
mkcert -cert-file tls.crt \
-key-file tls.key \
harbor.lab.home

kubectl create secret generic harbor \
--from-file=./tls.crt \
--from-file=./tls.key \
--from-file="$(mkcert -CAROOT)"/rootCA.pem \
--namespace harbor \
--dry-run=client \
-o json | kubeseal > manifests/harbor/harbor-tls.json

# Spring PetClinic
mkcert \
-cert-file tls.crt \
-key-file tls.key \
spring-petclinic.lab.home

kubectl create secret tls spring-petclinic-tls \
--namespace spring-petclinic \
--cert=./tls.crt \
--key=./tls.key \
--dry-run=client \
-o json | kubeseal > manifests/spring-petclinic/ingress-tls.json

# Pipeline secrets
kubectl create secret generic tanzu-gitops \
--namespace concourse-secrets-main \
--from-literal=tkgi_cluster="${TKGI_CLUSTER}" \
--from-literal=tkgi_url="${TKGI_URL}" \
--from-literal=tkgi_user="${TKGI_USER}" \
--from-literal=tkgi_password="${TKGI_PASSWORD}" \
--dry-run=client \
-o json | kubeseal > manifests/concourse/pipeline-secrets.json

