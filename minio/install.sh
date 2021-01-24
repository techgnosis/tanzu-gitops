#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install minio minio \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 3.7.9 \
--wait \
--namespace minio \
--create-namespace \
--values helm.yml

kapp deploy -a minio -f <(ytt --data-values-env=YTT_HOMELAB \
-f virtualservice.yml \
-f values.yml)