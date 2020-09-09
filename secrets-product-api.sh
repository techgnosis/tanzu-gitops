#! /usr/bin/env bash

set -euo pipefail

kubectx product-api

# Ingress secret
mkcert \
-cert-file tls.crt \
-key-file tls.key \
product-api.lab.home

kubectl create secret tls product-api-tls \
--namespace product-api \
--cert=./tls.crt \
--key=./tls.key \
--dry-run=client \
-o json | kubeseal > manifests/product-api/ingress-tls.json

