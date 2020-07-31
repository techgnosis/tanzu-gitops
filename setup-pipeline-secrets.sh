#! /usr/bin/env bash

set -euo pipefail


export TKGI_URL="https://pks.lab.home:9021"
export TKGI_USER="admin"
export TKGI_PASSWORD="x4GV_994Mkhx7FBnwLgUmmfG3oIGVRGb"
export TKGI_CLUSTER="cluster1"
export CONCOURSE_GITHUB_PRIVATEKEY="$(cat $HOME/.ssh/concourse)"


# Pipeline secrets
kubectl create secret generic tanzu-gitops \
--namespace concourse-main \
--from-literal=tkgi_cluster="${TKGI_CLUSTER}" \
--from-literal=tkgi_url="${TKGI_URL}" \
--from-literal=tkgi_user="${TKGI_USER}" \
--from-literal=tkgi_password="${TKGI_PASSWORD}" \
--from-file=ca_cert="$(mkcert -CAROOT)/rootCA.pem" \
--from-file=concourse_github_privatekey="${CONCOURSE_GITHUB_PRIVATEKEY}" \
--dry-run=client \
-o json | kubeseal > manifests/concourse-main/pipeline-secrets.json

