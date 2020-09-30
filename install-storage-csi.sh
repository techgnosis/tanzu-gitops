#! /usr/bin/env bash

set -euo pipefail

kubectl create secret generic vsphere-config-secret \
--from-file=./minio/csi-vsphere.conf \
--namespace=kube-system \
--dry-run=client \
-o json | kubeseal > ./minio/csi-secret.json

kapp deploy -a csi-driver \
-f ./minio/csi-secret.json \
-f ./minio/vsphere-csi-controller-rbac.yml \
-f ./minio/vsphere-csi-controller-ss.yml \
-f ./minio/vsphere-csi-node-ds.yml \
-f ./minio/storageclass.yml