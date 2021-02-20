#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a cert-manager \
-f cert-manager.yaml \
-f clusterissuer.yml \
-f <(kubectl create secret generic mkcert \
--from-file=tls.crt="$(mkcert -CAROOT)"/rootCA.pem \
--from-file=tls.key="$(mkcert -CAROOT)"/rootCA-key.pem \
--namespace cert-manager \
--dry-run=client \
-o yaml)