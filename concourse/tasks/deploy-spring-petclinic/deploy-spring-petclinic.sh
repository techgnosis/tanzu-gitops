#! /usr/bin/env bash

set -euo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}


kapp deploy -a spring-petclinic -c -y -f tanzu-gitops/manifests/spring-petclinic