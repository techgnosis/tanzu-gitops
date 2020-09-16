#! /usr/bin/env bash

set -euo pipefail

ytt --data-values-env=YTT_SPRINGPETCLINIC -f manifests/spring-petclinic \
| kapp deploy -a spring-petclinic -f- -f manifests/spring-petclinic/wavefront-secrets.json -y