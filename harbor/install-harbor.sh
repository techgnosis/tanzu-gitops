#! /usr/bin/env bash

set -euo pipefail


helm install harbor harbor \
--repo https://helm.goharbor.io \
--version 1.5.0 \
--values helm.yml


kapp deploy -a harbor -f <(ytt --data-values-env=YTT_HARBOR \
-f certificate-harbor.yml \
-f certificate-notary.yml \
-f values.yml)