#! /usr/bin/env bash

set -euo pipefail

helm install contour contour \
--repo https://charts.bitnami.com/bitnami \
--version 2.3.2 \
--values helm.yml \
--wait \
--namespace contour \
--create-namespace