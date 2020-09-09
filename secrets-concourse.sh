#! /usr/bin/env bash

set -euo pipefail


kubectx concourse


read -p "TKGI URL: " TKGI_URL
read -p "TKGI_USER: " TKGI_USER
read -p "TKGI_PASSWORD: " TKGI_PASSWORD
read -p "INFRA_CLUSTER: " INFRA_CLUSTER
read -p "WORKLOAD_CLUSTER: " WORKLOAD_CLUSTER
read -p "WAVEFRONT API TOKEN: " WAVEFRONT_API_TOKEN
read -p "WAVEFRONT_URL: " WAVEFRONT_URL
read -p "PIVNET API TOKEN: " PIVNET_API_TOKEN
read -p "PIVNET USERNAME: " PIVNET_USERNAME
read -p "PIVNET PASSWORD: " PIVNET_PASSWORD




# Pipeline secrets

kubectl create secret generic tanzu-gitops \
--namespace concourse-main \
--from-literal=infra_cluster="${INFRA_CLUSTER}" \
--from-literal=workload_cluster="${WORKLOAD_CLUSTER}" \
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


# Concourse TLS
mkcert \
-cert-file tls.crt \
-key-file tls.key \
concourse.lab.home

kubectl create secret tls concourse-web-tls \
--namespace concourse \
--cert=./tls.crt \
--key=./tls.key \
--dry-run=client \
-o json | kubeseal > manifests/concourse/concourse-web-tls.json

