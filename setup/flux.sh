#! /usr/bin/env bash

set -euo pipefail

export GHUSER="techgnosis"

fluxctl install \
--git-user=${GHUSER} \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=git@github.com:techgnosis/k8s-petclinic.git \
--git-path="." \
--namespace=petclinic | kubectl apply -f -


