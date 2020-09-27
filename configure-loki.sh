#! /usr/bin/env bash

set -euo pipefail

echo "Grafana login"
kubectl get secret loki-grafana \
--namespace loki \
-o jsonpath="{.data.admin-password}" | base64 --decode ; echo

