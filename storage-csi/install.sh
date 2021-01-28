#! /usr/bin/env bash

set -euo pipefail

CLUSTER_NAME=$1

cp csi-vsphere-template.conf csi-vsphere.conf
sd "<CLUSTERNAME>" $CLUSTER_NAME csi-vsphere.conf
sd "<VCENTER_USER>" $VCENTER_USER csi-vsphere.conf
sd "<VCENTER_PASSWORD>" $VCENTER_PASSWORD csi-vsphere.conf
sd "<VCENTER_DATACENTER>" $VCENTER_DATACENTER csi-vsphere.conf
sd "<VCENTER_IP>" $VCENTER_IP csi-vsphere.conf

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