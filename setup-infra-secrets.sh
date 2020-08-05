#! /usr/bin/env bash

set -euo pipefail

# This is the only pre-existing file that is required
if [ ! -f "${HOME}/.ssh/concourse" ]; then
    echo "Concourse needs to push commits back to Git"
    echo "You must have an SSH private key at $HOME/.ssh/concourse"
    echo "That key must be added as a Deploy Key in GitHub to tanzu-gitops repo"
    exit 1
fi


# Collect the secret data
export CONCOURSE_GITHUB_PRIVATEKEY="$(cat $HOME/.ssh/concourse)"

read -p "TKGI URL: " TKGI_URL
read -p "TKGI_USER: " TKGI_USER
read -p "TKGI_PASSWORD: " TKGI_PASSWORD
read -p "TKGI_CLUSTER: " TKGI_CLUSTER
read -p "WAVEFRONT API TOKEN: " WAVEFRONT_API_TOKEN
read -p "WAVEFRONT_URL: " WAVEFRONT_URL



# Pipeline secrets

kubectl create secret generic tanzu-gitops \
--namespace concourse-main \
--from-literal=tkgi_cluster="${TKGI_CLUSTER}" \
--from-literal=tkgi_url="${TKGI_URL}" \
--from-literal=tkgi_user="${TKGI_USER}" \
--from-literal=tkgi_password="${TKGI_PASSWORD}" \
--from-file=ca_cert="$(mkcert -CAROOT)/rootCA.pem" \
--from-literal=concourse_github_privatekey="${CONCOURSE_GITHUB_PRIVATEKEY}" \
--from-literal=wavefront_api_token="${WAVEFRONT_API_TOKEN}" \
--from-literal=wavefront_url="${WAVEFRONT_URL}" \
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

# Harbor
mkcert -cert-file tls.crt \
-key-file tls.key \
harbor.lab.home

kubectl create secret generic harbor \
--from-file=./tls.crt \
--from-file=./tls.key \
--from-file="$(mkcert -CAROOT)"/rootCA.pem \
--namespace harbor \
--dry-run=client \
-o json | kubeseal > manifests/harbor/harbor-tls.json

