#! /usr/bin/env bash

set -euo pipefail

vault login

vault auth enable kubernetes


vault write auth/kubernetes/config \
kubernetes_host="https://cluster1.lab.home"


vault write auth/kubernetes/role/kes \
bound_service_account_names=kes-kubernetes-external-secrets \
bound_service_account_namespaces=kes \
policies=default \
ttl=1h
