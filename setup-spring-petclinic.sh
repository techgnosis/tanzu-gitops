#! /usr/bin/env bash

set -euo pipefail

# Make the Ingress TLS pem files locally on disk
mkcert \
-cert-file tls.crt \
-key-file tls.key \
spring-petclinic.lab.home

# Make the TLS secret for PetClinic Ingress using the on-disk pem files
kubectl create secret tls spring-petclinic-tls \
--namespace spring-petclinic \
--cert=./tls.crt \
--key=./tls.key \
--dry-run=client \
-o json | kubeseal > manifests/spring-petclinic/ingress-tls.json


