#! /usr/bin/env bash

set -xeuo pipefail

tkgi login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

tkgi get-credentials ${tkgicluster}

ytt --data-values-env=YTT_KUBEAPPS -f manifests/kubeapps \
| kapp deploy -a kubeapps -f- -y