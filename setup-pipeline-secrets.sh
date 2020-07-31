#! /usr/bin/env bash

set -euo pipefail


export TKGI_URL=""
export TKGI_USER=""
export TKGI_PASSWORD=""
export TKGI_CLUSTER=""


# Pipeline secrets
kubectl create secret generic tanzu-gitops \
--namespace concourse-main \
--from-literal=tkgi_cluster="${TKGI_CLUSTER}" \
--from-literal=tkgi_url="${TKGI_URL}" \
--from-literal=tkgi_user="${TKGI_USER}" \
--from-literal=tkgi_password="${TKGI_PASSWORD}" \
--from-file=ca_cert="$(mkcert -CAROOt)/rootCA.pem" \
--from-file=concourse_github_privatekey="~/.ssh/concourse" \
--dry-run=client \
-o json | kubeseal > manifests/concourse/pipeline-secrets.json

