#! /usr/bin/env bash

set -euo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

cd sockshop-front-end
REVISION=$(git rev-parse HEAD)
kp -n images image patch sockshop-front-end --git-revision ${REVISION}

