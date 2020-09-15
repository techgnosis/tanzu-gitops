#! /usr/bin/env bash

set -euo pipefail

# Root cert and key
kubectl create secret generic mkcert \
--from-file=tls.crt="$(mkcert -CAROOT)"/rootCA.pem \
--from-file=tls.key="$(mkcert -CAROOT)"/rootCA-key.pem \
--namespace cert-manager \
--dry-run=client \
-o json | kubeseal > manifests/cert-manager/mkcert.json

