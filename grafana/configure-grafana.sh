#! /usr/bin/env bash

set -euo pipefail

kubectl get secret -n grafana grafana-admin -o jsonpath='{.data.GF_SECURITY_ADMIN_PASSWORD}' -o go-template='{{.data.GF_SECURITY_ADMIN_PASSWORD | base64decode}}' && echo
