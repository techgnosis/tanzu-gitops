#! /usr/bin/env bash

set -euo pipefail

tkgi get-credentials harbor
tkgi get-credentials tbs
tkgi get-credentials concourse
tkgi get-credentials spring-petclinic
tkgi get-credentials product-api
tkgi get-credentials kubeapps
tkgi get-credentials tas
