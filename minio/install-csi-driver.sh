#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a csi-driver \
-f csi-secret.json \
-f vsphere-csi-controller-rbac.yml \
-f vsphere-csi-controller-ss.yml \
-f vsphere-csi-node-ds.yml \
-f storageclass.yml