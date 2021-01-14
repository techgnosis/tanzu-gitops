#! /usr/bin/env bash

set -euo pipefail 




kapp deploy -a spring-petclinic \
-f <(kubectl create secret generic wavefront \
--namespace spring-petclinic \
--from-literal=wavefront_api_token="${WAVEFRONT_API_TOKEN}" \
--from-literal=wavefront_url="${WAVEFRONT_URL}" \
-o yaml \
--dry-run=client) \
-f <(ytt --data-values-env=YTT_SPRINGPETCLINIC \
-f deployment.yml \
-f virtualservice.yml \
-f pdb.yml \
-f namespace.yml \
-f services.yml \
-f values.yaml)