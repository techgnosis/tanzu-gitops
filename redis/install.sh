#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install redis redis \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 12.7.2 \
--wait \
--namespace redis \
--create-namespace \
--values helm.yml

kapp deploy -a redis \
-f tcpproxy.yml \
-f certificate.yml