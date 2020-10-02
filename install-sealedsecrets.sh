#! /usr/bin/env bash

set -euo pipefail

cd manifests/sealed-secrets/
airgap.sh controller.yaml $HARBOR_DOMAIN/library/sealed-secrets
kapp deploy -a sealed-secrets -f relocated.yml