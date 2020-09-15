#! /usr/bin/env bash

set -euo pipefail

read -p "WAVEFRONT API TOKEN: " WAVEFRONT_API_TOKEN
read -p "WAVEFRONT_URL: " WAVEFRONT_URL


# spring-petclinic Wavefront secret
kubectl create secret generic wavefront \
--namespace spring-petclinic \
--from-literal=wavefront_api_token="${WAVEFRONT_API_TOKEN}" \
--from-literal=wavefront_url="${WAVEFRONT_URL}" \
--dry-run=client \
-o json | kubeseal > manifests/spring-petclinic/wavefront-secrets.json

# argo rollout Wavefront secret
kubectl create secret generic wavefront-api-tokens \
--namespace spring-petclinic \
--from-literal=vmware.wavefront.com="${WAVEFRONT_API_TOKEN}" \
--dry-run=client \
-o json | kubeseal > manifests/spring-petclinic/argo-rollouts-wavefront.json
