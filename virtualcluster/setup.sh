#! /usr/bin/env bash

set -euo pipefail

chmod 600 kubeconfig.yml
kubectl exec virtualcluster-0 --namespace virtualcluster -c syncer -- cat /root/.kube/config > kubeconfig.yml
chmod 400 kubeconfig.yml

kubectl port-forward virtualcluster-0 -n virtualcluster 8443:8443
