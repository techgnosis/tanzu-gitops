#! /usr/bin/env bash

set -euo pipefail

cd concourse/helper
docker build -t harbor.lab.home/library/concourse-helper:1 .
docker tag harbor.lab.home/library/concourse-helper:1 harbor.lab.home/library/concourse-helper:latest
docker push harbor.lab.home/library/concourse-helper:1