#! /usr/bin/env bash

set -euo pipefail

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-$1
kubectx $1 && kapp delete -a tmc