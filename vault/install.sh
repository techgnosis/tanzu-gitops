#! /usr/bin/env bash

set -euo pipefail


helm install vault vault \
--repo https://helm.releases.hashicorp.com \
--namespace vault \
--create-namespace \
--version "0.7.0" \
--values helm.yml

kapp deploy -a vault -f <(ytt --data-values-env=YTT_VAULT \
-f certificate.yml \
-f ingress.yml \
-f values.yml)

