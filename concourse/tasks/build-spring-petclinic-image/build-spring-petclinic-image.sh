#! /usr/bin/env bash

set -euo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

cd spring-petclinic
REVISION=$(git rev-parse HEAD)
kp -n spring-petclinic image patch spring-petclinic --git-revision ${REVISION}

