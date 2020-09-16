#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

export DIGEST=$(cat spring-petclinic-image/digest)
kubectl -n spring-petclinic set image deployment/spring-petclinic spring-petclinic=${harbor-domain}/library/spring-petclinic@$DIGEST