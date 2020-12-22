#! /usr/bin/env bash

set -euo pipefail

kubectl create secret generic vsphere-config-secret \
--from-file=csi-vsphere.conf \
--namespace=kube-system

kapp deploy -a csi-driver \
-f vsphere-csi-controller-rbac.yml \
-f vsphere-csi-controller-deployment.yml \
-f vsphere-csi-node-ds.yml \
-f storageclass.yml