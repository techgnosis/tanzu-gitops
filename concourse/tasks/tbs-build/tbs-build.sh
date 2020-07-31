#! /usr/bin/env bash

set -xeuo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

cd app-source
REVISION=$(git rev-parse HEAD)
kp -n ${namespace} image patch ${imagename} --git-revision ${REVISION}

