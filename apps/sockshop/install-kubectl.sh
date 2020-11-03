#! /usr/bin/env bash

set -euo pipefail

kubectl apply -f namespace.yml

kubectl apply -f <(ytt --data-values-env=YTT_SOCKSHOP -f certificate.yml -f ingress.yml -f values.yml)

kubectl apply -f carts.yml -f front-end.yml -orders.yml -f queue-master.yml -f shipping.yml \
-f sockshop.yml