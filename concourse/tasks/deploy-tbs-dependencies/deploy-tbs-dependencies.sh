#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

docker login registry.pivotal.io -u ${pivnetusername} -p ${pivnetpassword}

# Do not delete this echo statement. For some reason
# if you do then the docker login afterward will try
# to login to 'domain' instead of the value of harbordomain.
# It's got to be something about how docker login processes
# text...who knows.
# I know you don't believe me - just try it
echo "${harbordomain}"
docker login "${harbordomain}" -u admin -p "tamale-trauma-coven-guffaw-merger-ted"

kp import -f ./tbs-dependencies/descriptor-*.yaml