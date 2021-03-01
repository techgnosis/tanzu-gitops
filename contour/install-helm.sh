#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install contour contour \
--repo https://charts.trials.tac.bitnami.com/demo \
--create-namespace \
--namespace contour \
--version 4.1.3 \
--wait