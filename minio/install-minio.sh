#! /usr/bin/env bash

set -euo pipefail

helm install minio minio \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 3.7.9 \
--wait \
--namespace minio \
--create-namespace \
--values helm.yml

kapp deploy -a minio -f <(ytt --data-values-env=YTT_MINIO \
-f certificate.yml \
-f ingress.yml \
-f values.yml)