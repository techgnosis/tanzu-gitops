#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

export DIGEST=$(cat sockshop-front-end-image/digest)
kubectl -n sockshop set image deployment/front-end front-end=${harbordomain}/library/sockshop-front-end@$DIGEST