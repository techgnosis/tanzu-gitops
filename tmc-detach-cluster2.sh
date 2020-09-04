#! /usr/bin/env bash

set -euo pipefail

tmc cluster delete --forget jmusselwhite-workload-cluster
kapp delete -a tmc