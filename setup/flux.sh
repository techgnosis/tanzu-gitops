#! /usr/bin/env bash

set -euo pipefail

VERB=$1

fluxctl install \
--git-email=flux@lab.home \
--git-url=git@github.com:techgnosis/k8s-petclinic \
--git-path="manifests" \
--namespace=petclinic | kubectl $VERB -f -
