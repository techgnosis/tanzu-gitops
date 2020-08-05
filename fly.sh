#! /usr/bin/env bash

set -euo pipefail

fly login \
--target=lab \
--concourse-url="https://concourse.lab.home" \
--username=test \
--password=test

fly set-pipeline -t lab \
-p tanzu-gitops \
-c concourse/pipeline/pipeline.yml
