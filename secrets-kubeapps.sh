#! /usr/bin/env bash

set -euo pipefail

kubectx kubeapps

# kubeapps Ingress secret
mkcert \
-cert-file tls.crt \
-key-file tls.key \
kubeapps.lab.home

kubectl create secret tls kubeapps.lab.home-tls \
--namespace default \
--cert=./tls.crt \
--key=./tls.key \
--dry-run=client \
-o json | kubeseal > manifests/kubeapps/ingress-tls.json

