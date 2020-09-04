#! /usr/bin/env bash

set -euo pipefail

tmc cluster attach --group jmusselwhite --name jmusselwhite-infra-cluster
kapp deploy -a tmc -f k8s-attach-manifest.yaml
rm k8s-attach-manifest.yaml