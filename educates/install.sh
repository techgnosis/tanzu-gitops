#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a educates \
-f systemprofile.yml \
-f <(kubectl apply -k "github.com/eduk8s/eduk8s?ref=20.12.03.1" --dry-run=client -o yaml)
#-f <(ytt --data-values-env=YTT_EDUKATE -f certificate.yml -f values.yml) \