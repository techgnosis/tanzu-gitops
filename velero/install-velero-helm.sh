#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a velero \
-f minio-creds-secret.yml \
-f namespace.yml

helm upgrade --install velero velero \
--repo https://vmware-tanzu.github.io/helm-charts \
--version 2.13.3 \
--wait \
--namespace velero \
--values helm.yml
