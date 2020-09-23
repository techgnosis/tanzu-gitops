#! /usr/bin/env bash

set -euo pipefail

helm template cert-manager jetstack/cert-manager \
--version "v1.0.1" > template.yml

airgap.sh template.yml harbor.lab.home/library/cert-manager