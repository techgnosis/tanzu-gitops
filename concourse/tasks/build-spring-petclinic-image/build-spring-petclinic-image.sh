#! /usr/bin/env bash

set -euo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

cd spring-petclinic
REVISION=$(git rev-parse HEAD)
kp -n images image patch spring-petclinic --git-revision ${REVISION}

