#! /usr/bin/env bash

set -euo pipefail

uaa-cli target https://$TKGI_HOSTNAME:8443
uaa-cli get-client-credentials-token admin -s $TKGI_ADMIN_CLIENT_SECRET

uaa-cli create-user tanzu-gitops \
--email tanzu-gitops@notreal.com \
--password tanzu-gitops

uaa-cli create-user spring-petclinic \
--email spring-petclinic@notreal.com \
--password spring-petclinic

uaa-cli add-member pks.clusters.manage tanzu-gitops