#! /usr/bin/env bash

set -euo pipefail

# Harbor
mkcert -cert-file tls.crt \
-key-file tls.key \
*.apps.sys.tas.$PRIMARY_DOMAIN \
*.sys.tas.$PRIMARY_DOMAIN

kubectl create secret generic tas-tls \
--from-file=./tls.crt \
--from-file=./tls.key \
--namespace istio-system \
--dry-run=client \
-o json | kubeseal > manifests/tas/tas-tls.json

