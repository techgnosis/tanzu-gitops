#! /usr/bin/env bash

set -euo pipefail

tmc cluster delete --forget jmusselwhite-infra-cluster
kapp delete -a tmc