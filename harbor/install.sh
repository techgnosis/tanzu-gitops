#! /usr/bin/env bash

set -euo pipefail


helm install harbor harbor \
--repo https://helm.goharbor.io \
--version 1.5.1 \
--values helm.yml \
--namespace harbor \
--create-namespace


kapp deploy -a harbor -f <(ytt --data-values-env=YTT_HOMELAB \
-f certificate-harbor.yml \
-f certificate-notary.yml \
-f values.yml)