#! /usr/bin/env bash

set -euo pipefail

if [ ! -f "${HOME}/.ssh/concourse" ]; then
    echo "Concourse needs to push commits back to Git"
    echo "You must have an SSH private key at $HOME/.ssh/concourse"
    echo "That key must be added as a Deploy Key in GitHub to tanzu-gitops repo"
    exit 1
fi

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

