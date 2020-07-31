#! /usr/bin/env bash

set -euo pipefail


read -p "TKGI URL: " TKGI_URL
read -p "TKGI_USER: " TKGI_USER
read -p "TKGI_PASSWORD: " TKGI_PASSWORD
read -p "TKGI_CLUSTER: " TKGI_CLUSTER
export CONCOURSE_GITHUB_PRIVATEKEY="$(cat $HOME/.ssh/concourse)"


# Pipeline secrets
kubectl create secret generic tanzu-gitops \
--namespace concourse-main \
--from-literal=tkgi_cluster="${TKGI_CLUSTER}" \
--from-literal=tkgi_url="${TKGI_URL}" \
--from-literal=tkgi_user="${TKGI_USER}" \
--from-literal=tkgi_password="${TKGI_PASSWORD}" \
--from-file=ca_cert="$(mkcert -CAROOT)/rootCA.pem" \
--from-literal=concourse_github_privatekey="${CONCOURSE_GITHUB_PRIVATEKEY}" \
--dry-run=client \
-o json | kubeseal > manifests/concourse-main/pipeline-secrets.json

