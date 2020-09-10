#! /usr/bin/env bash

set -xeuo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

docker login registry.pivotal.io -u ${pivnetusername} -p ${pivnetpassword}

kp import -f ./tbs-dependencies/descriptor-*.yaml