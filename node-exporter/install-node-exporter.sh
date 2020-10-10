#! /usr/bin/env bash

set -euo pipefail

helm install node-exporter tac-repo/node-exporter \
--version 1.1.2 \
--values helm.yml \
--create-namespace \
--namespace node-exporter \
--wait