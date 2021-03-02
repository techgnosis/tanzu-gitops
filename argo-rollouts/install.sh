#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a argo-rollouts \
-f namespace.yml \
--into-ns=argo-rollouts \
-f https://raw.githubusercontent.com/argoproj/argo-rollouts/stable/manifests/install.yaml
