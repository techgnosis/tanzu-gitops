#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a ingress-nginx -f ingress-nginx.yml -y