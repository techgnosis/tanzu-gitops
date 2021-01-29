#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install contour contour \
--repo https://charts.bitnami.com/bitnami \
--version 4.1.0 \
--wait \
--namespace contour \
--create-namespace