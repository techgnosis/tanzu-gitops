#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install concourse concourse \
--repo https://concourse-charts.storage.googleapis.com \
--create-namespace \
--namespace concourse \
--version 14.6.0 \
--values helm.yml \
--set concourse.web.externalUrl="https://concourse.$PRIMARY_DOMAIN" \
--wait


kapp deploy \
-a concourse \
-f <(kubectl create secret generic tanzu-gitops \
--namespace concourse-main \
--from-literal=tkgi_url="https://${TKGI_HOSTNAME}:9021" \
--from-literal=tkgi_user="${TKGI_USER}" \
--from-literal=tkgi_password="${TKGI_PASSWORD}" \
--from-file=ca_cert="$(mkcert -CAROOT)/rootCA.pem" \
--from-literal=wavefront_api_token="${WAVEFRONT_API_TOKEN}" \
--from-literal=wavefront_url="${WAVEFRONT_URL}" \
--from-literal=pivnet_api_token="${PIVNET_API_TOKEN}" \
--from-literal=pivnet_username="${PIVNET_LOGIN}" \
--from-literal=pivnet_password="${PIVNET_PASSWORD}" \
--dry-run=client \
-o yaml) \
-f <(ytt --data-values-env=YTT_HOMELAB \
-f certificate.yml \
-f ingress.yml \
-f values.yml)
