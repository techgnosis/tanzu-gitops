#! /usr/bin/env bash

set -euo pipefail

read -p "WAVEFRONT API TOKEN: " WAVEFRONT_API_TOKEN
read -p "WAVEFRONT_URL: " WAVEFRONT_URL


# spring-petclinic Wavefront secret
kubectl create secret generic wavefront \
--namespace spring-petclinic \
--from-literal=wavefront_api_token="${WAVEFRONT_API_TOKEN}" \
--from-literal=wavefront_url="${WAVEFRONT_URL}" \
--dry-run=client \
-o json | kubeseal > manifests/spring-petclinic/wavefront-secrets.json


# spring-petclinic Ingress secret
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


# locust Ingress secret
mkcert \
-cert-file tls.crt \
-key-file tls.key \
locust.lab.home

kubectl create secret tls locust-tls \
--namespace locust \
--cert=./tls.crt \
--key=./tls.key \
--dry-run=client \
-o json | kubeseal > manifests/locust/ingress-tls.json

