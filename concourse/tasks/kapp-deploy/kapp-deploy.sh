#! /usr/bin/env bash

set -euo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}


kapp deploy -a $appname -c -y -f deploy-source/manifests/$appname