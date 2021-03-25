#! /usr/bin/env bash

set -euo pipefail

om \
staged-config \
--product-name pivotal-container-service \
--include-credentials > tkgi.yml


om \
staged-director-config --no-redact > bosh.yml

