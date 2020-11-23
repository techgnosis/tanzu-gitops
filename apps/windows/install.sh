#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a windows -f <(ytt --data-values-env=YTT_WINDOWS \
-f certificate.yml \
-f windows.yml \
-f service.yml \
-f namespace.yml \
-f values.yaml \
-f ingress.yml)
