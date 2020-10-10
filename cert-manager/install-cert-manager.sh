#! /usr/bin/env bash

set -euo pipefail

helm install cert-manager jetstack/cert-manager \
--values helm.yml \
--version "v1.0.1" \
--create-namespace \
--namespace cert-manager \
--wait

kapp deploy -a cert-manager \
-f cert-manager.crds.yaml \
-f clusterissuer.yml


# Root cert and key
kubectl create secret generic mkcert \
--from-file=tls.crt="$(mkcert -CAROOT)"/rootCA.pem \
--from-file=tls.key="$(mkcert -CAROOT)"/rootCA-key.pem \
--namespace cert-manager