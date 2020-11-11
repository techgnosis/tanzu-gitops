#! /usr/bin/env bash

set -euo pipefail

helm install contour contour \
--repo https://charts.bitnami.com/bitnami \
--version 2.3.4 \
--wait \
--namespace contour \
--create-namespace