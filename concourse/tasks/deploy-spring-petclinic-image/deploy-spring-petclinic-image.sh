#! /usr/bin/env bash

set -xeuo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

export DIGEST=$(cat spring-petclinic-image/digest)

kubectl argo rollouts set image -n spring-petclinic spring-petclinic=harbor.lab.home/library/spring-petclinic@$DIGEST