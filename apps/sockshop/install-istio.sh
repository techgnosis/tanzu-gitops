#! /usr/bin/env bash

set -euo pipefail

# The istio files turn off mTLS
# I dont remember why I had to do that but I suspect things didn't work with TLS enabled

kapp deploy -a sockshop -f <(ytt --data-values-env=YTT_SOCKSHOP \
-f sockshop.yml \
-f front-end.yml \
-f namespace.yml \
-f certificate.yml \
-f ingress.yml \
-f values.yml \
-f dbs.yml \
-f istio/destinationrule.yml \
-f istio/policy.yml)
