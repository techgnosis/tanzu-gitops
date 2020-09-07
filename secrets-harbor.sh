#! /usr/bin/env bash

set -euo pipefail

kubectx harbor

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

