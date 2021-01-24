#! /usr/bin/env bash

set -euo pipefail



kapp deploy -a cns-csi-driver \
-f <(kubectl create secret generic vsphere-config-secret \
--from-file=csi-vsphere.conf \
--namespace=kube-system \
--dry-run=client \
-o yaml) \
-f vsphere-csi-controller-rbac.yaml \
-f vsphere-csi-controller-deployment.yaml \
-f vsphere-csi-node-ds.yaml \
-f storageclass.yml