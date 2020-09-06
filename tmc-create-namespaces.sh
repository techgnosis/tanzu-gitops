#! /usr/bin/env bash

set -euo pipefail

tmc cluster namespace create \
--cluster-name jmusselwhite-workload-cluster \
--name base-platform \
--description "base platform shared by all app teams" \
--workspace-name base-platform