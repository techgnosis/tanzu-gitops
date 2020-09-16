#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

export DIGEST=$(cat product-api-image/digest)
kubectl -n product-api set image deployment/product-api product-api=${harbor-domain}/library/product-api@$DIGEST