#! /usr/bin/env bash

set -euo pipefail

kubectl get secret $(kubectl get serviceaccount kubeapps -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-token) -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo
