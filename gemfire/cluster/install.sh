#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a gemfire-cluster \
-f cluster.yml \
-f namespace.yml

kubectl apply -f service-redis.yml