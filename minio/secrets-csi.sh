#! /usr/bin/env bash

set -euo pipefail

kubectl create secret generic vsphere-config-secret \
--from-file=csi-vsphere.conf \
--namespace=kube-system \
--dry-run=client \
-o json | kubeseal > csi-secret.json