#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a product-api -f <(ytt --data-values-env=YTT_PRODUCTAPI -f manifests/product-api)