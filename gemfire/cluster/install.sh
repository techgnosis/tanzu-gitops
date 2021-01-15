#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a gemfire-cluster \
-f cluster.yml \
-f namespace.yml