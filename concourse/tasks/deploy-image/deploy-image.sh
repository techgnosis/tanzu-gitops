#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

export DIGEST=$(cat image/digest)
kubectl -n ${namespace} set image deployment/${deployment} ${container}=${harbordomain}/library/${image}@${DIGEST}