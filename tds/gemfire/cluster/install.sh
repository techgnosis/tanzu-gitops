#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a gemfire-cluster \
-f cluster.yml \
-f namespace.yml

# kapp modifies the selector of Services it deploys
# if you don't deploy the Pods with the Services it does not work
# gotta use kubectl for the Service since the operator deployed the Pods
kubectl apply -f service-redis.yml