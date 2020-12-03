#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install minibroker minibroker \
--repo https://minibroker.blob.core.windows.net/charts \
--version "1.2.0" \
--values helm.yml \
--namespace minibroker \
--create-namespace \
--wait
