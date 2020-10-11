#! /usr/bin/env bash

set -euo pipefail 

kapp deploy -a spring-petclinic \
-f wavefront-secrets.json \
-f <(ytt --data-values-env=YTT_SPRINGPETCLINIC -f certificate.yml \
-f deployment.yml \
-f ingress.yml \
-f pdb.yml \
-f services.yml \
-f values.yaml)