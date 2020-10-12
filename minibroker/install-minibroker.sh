#! /usr/bin/env bash

set -euo pipefail

helm install minibroker minibroker \
--repo https://minibroker.blob.core.windows.net/charts \
--version "0.3.1" \
--values helm.yml \
--wait
