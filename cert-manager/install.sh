#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install cert-manager cert-manager \
--repo https://charts.jetstack.io \
--version 1.2.0 \
--namespace cert-manager \
--create-namespace \
--set installCRDs=true \
--wait


kapp deploy -a cert-manager \
-f clusterissuer.yml \
-f <(kubectl create secret generic mkcert \
--from-file=tls.crt="$(mkcert -CAROOT)"/rootCA.pem \
--from-file=tls.key="$(mkcert -CAROOT)"/rootCA-key.pem \
--namespace cert-manager \
--dry-run=client \
-o yaml)