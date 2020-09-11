#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

export DIGEST=$(cat product-api-image/digest)

kubectl argo rollouts set image -n product-api product-api product-api=harbor.lab.home/library/product-api@$DIGEST