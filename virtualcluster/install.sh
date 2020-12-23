#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install virtualcluster virtualcluster \
--repo https://charts.devspace.sh \
--namespace virtualcluster \
--values helm.yml \
--create-namespace \
--wait