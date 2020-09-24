#! /usr/bin/env bash

set -euo pipefail 

kapp deploy -a spring-petclinic \
-f manifests/spring-petclinic/wavefront-secrets.json \
-f <(ytt --data-values-env=YTT_SPRINGPETCLINIC -f manifests/spring-petclinic)