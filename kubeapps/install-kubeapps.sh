#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a kubeapps -f <(ytt --data-values-env=YTT_KUBEAPPS \
-f certificate.yml \
-f cluster-role-binding.yml \
-f ingress.yml \
-f kubeapps.yml \
-f service-account.yml \
-f values.yml)