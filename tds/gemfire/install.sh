#! /usr/bin/env bash

set -euo pipefail


helm upgrade --install gemfire-operator gemfire-operator-1.0.0.tgz \
--set controllerImage="$HARBOR_DOMAIN/library/gemfire-controller:1.0.0" \
--namespace gemfire-system \
--create-namespace \
--wait