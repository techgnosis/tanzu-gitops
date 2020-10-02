#! /usr/bin/env bash

set -euo pipefail

helm install cert-manager harbor/library/cert-manager \
--values manifests/cert-manager/helm.yml \
--version "v1.0.1" \
--create-namespace \
--namespace cert-manager \
--wait

kapp deploy -a cert-manager \
-f manifests/cert-manager/cert-manager.crds.yaml \
-f manifests/cert-manager/clusterissuer.yml


# Root cert and key
kubectl create secret generic mkcert \
--from-file=tls.crt="$(mkcert -CAROOT)"/rootCA.pem \
--from-file=tls.key="$(mkcert -CAROOT)"/rootCA-key.pem \
--namespace cert-manager