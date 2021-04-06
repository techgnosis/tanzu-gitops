#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install fluent-bit fluent-bit \
--repo https://grafana.github.io/helm-charts \
--set loki.serviceName=loki.lab.home \
--namespace fluent-bit \
--create-namespace