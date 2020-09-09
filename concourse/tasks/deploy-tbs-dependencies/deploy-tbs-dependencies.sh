#! /usr/bin/env bash

set -xeuo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

cp /tmp/build/get/descriptor-*.yaml /tmp/build/get/tbs-dependencies.yaml
kp import -f /tmp/build/get/tbs-dependencies.yaml