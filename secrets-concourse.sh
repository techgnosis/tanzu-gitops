#! /usr/bin/env bash

set -euo pipefail


read -p "TKGI URL: " TKGI_URL
read -p "TKGI_USER: " TKGI_USER
read -p "TKGI_PASSWORD: " TKGI_PASSWORD
read -p "WAVEFRONT API TOKEN: " WAVEFRONT_API_TOKEN
read -p "WAVEFRONT_URL: " WAVEFRONT_URL
read -p "PIVNET API TOKEN: " PIVNET_API_TOKEN
read -p "PIVNET USERNAME: " PIVNET_USERNAME
read -p "PIVNET PASSWORD: " PIVNET_PASSWORD




# Pipeline secrets

kubectl create secret generic tanzu-gitops \
--namespace concourse-main \
--from-literal=tkgi_url="${TKGI_URL}" \
--from-literal=tkgi_user="${TKGI_USER}" \
--from-literal=tkgi_password="${TKGI_PASSWORD}" \
--from-file=ca_cert="$(mkcert -CAROOT)/rootCA.pem" \
--from-literal=wavefront_api_token="${WAVEFRONT_API_TOKEN}" \
--from-literal=wavefront_url="${WAVEFRONT_URL}" \
--from-literal=pivnet_api_token="${PIVNET_API_TOKEN}" \
--from-literal=pivnet_username="${PIVNET_USERNAME}" \
--from-literal=pivnet_password="${PIVNET_PASSWORD}" \
--dry-run=client \
-o json | kubeseal > manifests/concourse-main/pipeline-secrets.json
