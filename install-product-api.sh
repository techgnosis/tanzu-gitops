#! /usr/bin/env bash

set -euo pipefail

ytt --data-values-env=YTT_PRODUCTAPI -f manifests/product-api \
| kapp deploy -a product-api -f- -y