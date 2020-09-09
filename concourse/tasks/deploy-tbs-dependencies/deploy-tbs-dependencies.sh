#! /usr/bin/env bash

set -xeuo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

DESCRIPTOR_NAME=$("ls /tmp/build/get/descriptor-*")
kp import -f $DESCRIPTOR_NAME