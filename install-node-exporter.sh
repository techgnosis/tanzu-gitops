#! /usr/bin/env bash

set -euo pipefail

helm install node-exporter harbor/library/node-exporter \
--version 1.1.1 \
--values manifests/node-exporter/helm.yml \
--create-namespace \
--namespace node-exporter \
--wait