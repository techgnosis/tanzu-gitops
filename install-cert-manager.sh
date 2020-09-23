#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a cert-manager -f manifests/cert-manager

# Root cert and key
kubectl create secret generic mkcert \
--from-file=tls.crt="$(mkcert -CAROOT)"/rootCA.pem \
--from-file=tls.key="$(mkcert -CAROOT)"/rootCA-key.pem \
--namespace cert-manager