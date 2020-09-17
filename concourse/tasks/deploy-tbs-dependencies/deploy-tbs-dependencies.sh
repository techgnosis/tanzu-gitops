#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

docker login registry.pivotal.io -u ${pivnetusername} -p ${pivnetpassword}
echo "${harbordomain}"
docker login "${harbordomain}" -u admin -p Harbor12345

kp import -f ./tbs-dependencies/descriptor-*.yaml