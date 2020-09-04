#! /usr/bin/env bash

set -euo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}


kubectl apply -f tanzu-gitops/manifests/spring-petclinic