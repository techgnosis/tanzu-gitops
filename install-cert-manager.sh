#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a cert-manager -f manifests/cert-manager