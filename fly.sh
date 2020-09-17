#! /usr/bin/env bash

set -euo pipefail

fly login \
--target=lab \
--concourse-url="https://concourse.$PRIMARY_DOMAIN" \
--username=test \
--password=test

fly set-pipeline -t lab \
-p spring-petclinic \
-c concourse/pipeline/spring-petclinic.yml \
-v harbordomain=$HARBOR_DOMAIN

fly set-pipeline -t lab \
-p product-api \
-c concourse/pipeline/product-api.yml \
-v harbordomain=$HARBOR_DOMAIN

fly set-pipeline -t lab \
-p harbor \
-c concourse/pipeline/harbor.yml \
-v harbordomain=$HARBOR_DOMAIN

fly set-pipeline -t lab \
-p kubeapps \
-c concourse/pipeline/kubeapps.yml \
-v harbordomain=$HARBOR_DOMAIN \
-v kubeappshostname=$KUBEAPPS_HOSTNAME

fly set-pipeline -t lab \
-p tbs \
-c concourse/pipeline/tbs.yml \
-v harbordomain=$HARBOR_DOMAIN
