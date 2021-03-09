#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a spring-petclinic-image \
-n spring-petclinic-image \
-f <(ytt --data-values-env YTT_HOMELAB \
-f image.yml \
-f tbs-service-account.yml \
-f harbor-docker-creds.yml \
-f values.yaml)