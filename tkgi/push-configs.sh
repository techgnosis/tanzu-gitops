#! /usr/bin/env bash

set -euo pipefail

om \
configure-director --config bosh.yml

om \
configure-product --config tkgi.yml
