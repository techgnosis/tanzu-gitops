#! /usr/bin/env bash

set -euo pipefail

fly login \
--target=lab \
--concourse-url="https://concourse.lab.home" \
--username=test \
--password=test

fly set-pipeline -t lab \
-p spring-petclinic \
-c concourse/pipeline/spring-petclinic.yml \
-v harbor-domain=$HARBOR_DOMAIN

fly set-pipeline -t lab \
-p product-api \
-c concourse/pipeline/product-api.yml \
-v harbor-domain=$HARBOR_DOMAIN

fly set-pipeline -t lab \
-p harbor \
-c concourse/pipeline/harbor.yml \
-v harbor-domain=$HARBOR_DOMAIN

fly set-pipeline -t lab \
-p kubeapps \
-c concourse/pipeline/kubeapps.yml \
-v harbor-domain=$HARBOR_DOMAIN

fly set-pipeline -t lab \
-p tbs \
-c concourse/pipeline/tbs.yml \
-v harbor-domain=$HARBOR_DOMAIN
