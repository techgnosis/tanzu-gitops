#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a istio-tls -f certificate.yml -f gateway.yml