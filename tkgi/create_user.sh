#! /usr/bin/env bash

set -euo pipefail

uaa-cli target https://$TKGI_HOSTNAME:8443
uaa-cli get-client-credentials-token admin -s $TKGI_ADMIN_CLIENT_SECRET

uaa-cli create-user tanzu-gitops \
--email tanzu-gitops@$PRIMARY_DOMAIN \
--password tanzu-gitops

uaa-cli add-member pks.clusters.manage tanzu-gitops