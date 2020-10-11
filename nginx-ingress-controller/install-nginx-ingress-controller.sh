#! /usr/bin/env bash

set -euo pipefail

helm install nginx-ingress-controller nginx-ingress-controller \
--repo https://charts.bitnami.com/bitnami \
--create-namespace \
--namespace nginx-ingress-controller \
--version 5.6.7 \
--values helm.yml