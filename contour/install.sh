#! /usr/bin/env bash

set -euo pipefail

helm install contour contour \
--repo https://charts.bitnami.com/bitnami \
--version 3.0.0 \
--wait \
--values helm.yml \
--namespace contour \
--create-namespace