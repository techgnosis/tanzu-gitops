#! /usr/bin/env bash

set -euo pipefail

helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add bitnami https://charts.bitnami.com/bitnami
helm dependency build ./ksm/
helm install ksm ./ksm/ -n ksm -f ksm/values-lab.yaml.template