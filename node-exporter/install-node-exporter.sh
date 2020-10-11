#! /usr/bin/env bash

set -euo pipefail

helm install node-exporter node-exporter \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 1.1.2 \
--values helm.yml \
--create-namespace \
--namespace node-exporter \
--wait