#! /usr/bin/env bash

set -xeuo pipefail

#tkgi login -a ${tkgiapi} \
#-u ${tkgiuser} \
#-p ${tkgipassword} \
#-k

#PKS_USER_PASSWORD=${tkgipassword} tkgi get-credentials ${tkgicluster}

KUBECTL_VSPHERE_PASSWORD=Tkgs-admin1! \
kubectl vsphere login \
--server=10.0.3.2 \
--vsphere-username tkgs-admin@vsphere.local \
--tanzu-kubernetes-cluster-name jmusselwhite-shared-services \
--tanzu-kubernetes-cluster-namespace myfriendthenamespace \
--insecure-skip-tls-verify

kubectl config use-context jmusselwhite-shared-services
cd source-code
REVISION=$(git rev-parse HEAD)
kp -n demo-app image patch ${image} --git-revision ${REVISION}

