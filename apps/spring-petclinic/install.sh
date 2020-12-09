#! /usr/bin/env bash

set -euo pipefail 


kubectl create secret generic wavefront \
--namespace spring-petclinic \
--from-literal=wavefront_api_token="${WAVEFRONT_API_TOKEN}" \
--from-literal=wavefront_url="${WAVEFRONT_URL}" 

kapp deploy -n spring-petclinic -a spring-petclinic \
-f <(ytt --data-values-env=YTT_SPRINGPETCLINIC -f certificate.yml \
-f deployment.yml \
-f ingress.yml \
-f pdb.yml \
-f services.yml \
-f values.yaml)