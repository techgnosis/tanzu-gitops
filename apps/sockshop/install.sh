#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a sockshop -f <(ytt --data-values-env=YTT_SOCKSHOP \
-f sockshop.yml \
-f front-end.yml \
-f namespace.yml \
-f certificate.yml \
-f ingress.yml \
-f values.yml)
#-f istio/destinationrule.yml \
#-f istio/policy.yml \