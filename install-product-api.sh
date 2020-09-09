#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a product-api -f manifests/product-api