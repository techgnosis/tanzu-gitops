#! /usr/bin/env bash

set -euo pipefail


helm install harbor harbor \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 9.4.4 \
--values helm.yml \
--namespace harbor \
--create-namespace


kapp deploy -a harbor -f <(ytt --data-values-env=YTT_HOMELAB \
-f certificate-harbor.yml \
-f certificate-notary.yml \
-f values.yml)