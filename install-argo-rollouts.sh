#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a argo-rollouts -f manifests/argo-rollouts --into-ns=argo-rollouts