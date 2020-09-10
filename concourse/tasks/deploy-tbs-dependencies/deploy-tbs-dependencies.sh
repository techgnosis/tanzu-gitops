#! /usr/bin/env bash

set -xeuo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

docker login registry.pivotal.io -u ${pivnetusername} -p ${pivnetpassword}
docker login harbor.lab.home -u admin -p Harbor12345

kp import -f ./tbs-dependencies/descriptor-*.yaml