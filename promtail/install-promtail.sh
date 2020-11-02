#! /usr/bin/env bash

set -euo pipefail


helm install promtail promtail \
--repo https://grafana.github.io/loki/charts \
--version 2.0.0 \
--namespace promtail \
--create-namespace \
--values helm.yml \
--wait


