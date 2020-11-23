#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a product-api -f <(ytt --data-values-env=YTT_PRODUCTAPI \
-f certificate.yml \
-f deployment.yml \
-f gateway.yml \
-f virtualservice.yml \
-f services.yml \
-f namespace.yml \
-f values.yaml)
#-f ingress.yml \
