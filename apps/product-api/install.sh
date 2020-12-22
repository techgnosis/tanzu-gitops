#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a product-api -f <(ytt --data-values-env=YTT_PRODUCTAPI \
-f Gateway.yml \
-f VirtualService.yml \
-f deployment.yml \
-f services.yml \
-f namespace.yml \
-f values.yaml)


