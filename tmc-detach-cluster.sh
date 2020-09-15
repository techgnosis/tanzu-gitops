#! /usr/bin/env bash

set -euo pipefail

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-$1
kubectl config use-context $1 && kapp delete -a tmc