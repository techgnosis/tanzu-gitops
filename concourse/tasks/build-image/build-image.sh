#! /usr/bin/env bash

set -euo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

cd source-code
REVISION=$(git rev-parse HEAD)
kp -n images image patch image --git-revision ${REVISION}

