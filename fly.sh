#! /usr/bin/env bash

set -euo pipefail

fly login \
--target=lab \
--concourse-url="https://concourse.lab.home" \
--username=test \
--password=test

fly set-pipeline -t lab \
-p spring-petclinic \
-c concourse/pipeline/spring-petclinic.yml

fly set-pipeline -t lab \
-p harbor \
-c concourse/pipeline/harbor.yml

fly set-pipeline -t lab \
-p kubeapps \
-c concourse/pipeline/kubeapps.yml
