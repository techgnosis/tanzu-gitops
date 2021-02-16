#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a cert-manager \
-f cert-manager.yaml
-f clusterissuer.yml