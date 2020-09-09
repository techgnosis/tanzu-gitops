#! /usr/bin/env bash

set -xeuo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

docker login registry.pivotal.io -u ${pivnetusername} -p ${pivnetpassword}

DESCRIPTOR_NAME=$("ls tbs-dependencies/descriptor-*")
kp import -f $DESCRIPTOR_NAME