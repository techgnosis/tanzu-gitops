#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a gemfire-cluster \
-n demo-app \
-f cluster.yml