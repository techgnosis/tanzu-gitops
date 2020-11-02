#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install kes kubernetes-external-secrets \
--repo https://godaddy.github.io/kubernetes-external-secrets \
--version 6.0.0 \
--create-namespace \
--namespace kes \
--values helm.yml \
--wait

kapp deploy -a kes \
-f service-account.yml \
-f vault-auth-service-account.yml \
-f externalsecret.yml