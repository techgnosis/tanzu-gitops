#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

PKS_USER_PASSWORD=${tkgipassword} tkgi get-credentials ${tkgicluster}

cd source-code
REVISION=$(git rev-parse HEAD)
kp -n demo-app-image image patch ${image} --git-revision ${REVISION}

