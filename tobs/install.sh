#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a wavefront-collector \
-f <(ytt --data-values-env=YTT_WAVEFRONT \
-f values.yaml \
-f proxy.yaml) \
-f 0-collector-namespace.yaml \
-f 1-collector-cluster-role.yaml \
-f 2-collector-rbac.yaml \
-f 3-collector-service-account.yaml \
-f 4-collector-config.yaml \
-f 5-collector-daemonset.yaml

kapp deploy -a kube-state-metrics -f kube-state.yaml