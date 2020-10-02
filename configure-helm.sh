#! /usr/bin/env bash

set -eup pipefail

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add concourse	https://concourse-charts.storage.googleapis.com/
helm repo add wavefront https://wavefronthq.github.io/helm/
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add minibroker https://minibroker.blob.core.windows.net/charts
helm repo add hashicorp	https://helm.releases.hashicorp.com
helm repo add external-secrets https://godaddy.github.io/kubernetes-external-secrets/
helm repo add fluxcd https://charts.fluxcd.io
helm repo add tac-repo https://charts.trials.tac.bitnami.com/demo
helm repo add svc-cat https://svc-catalog-charts.storage.googleapis.com
helm repo add jetstack https://charts.jetstack.io
helm repo add loki https://grafana.github.io/loki/charts