#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a ingress-nginx -f manifests/ingress-nginx/ingress-nginx.yml -y