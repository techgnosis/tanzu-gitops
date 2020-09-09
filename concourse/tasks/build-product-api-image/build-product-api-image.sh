#! /usr/bin/env bash

set -euo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

cd product-api
REVISION=$(git rev-parse HEAD)
kp -n images image patch product-api --git-revision ${REVISION}

