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
export DIGEST=$(cat image/digest)
kubectl -n ${namespace} set image deployment/${deployment} ${container}=${harbordomain}/library/${image}@${DIGEST}