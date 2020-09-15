#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

ytt --data-values-env=YTT_HARBOR -f tanzu-gitops/manifests/harbor \
| kapp deploy -a harbor -f- -y