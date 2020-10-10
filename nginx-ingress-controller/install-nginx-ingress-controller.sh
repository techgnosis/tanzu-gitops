#! /usr/bin/env bash

set -euo pipefail

helm install nginx-ingress-controller bitnami/nginx-ingress-controller \
--create-namespace \
--namespace nginx-ingress-controller \
--version 5.6.7 \
--values helm.yml