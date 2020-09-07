#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a sealed-secrets -f manifests/sealed-secrets/controller.yaml -y