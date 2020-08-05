#! /usr/bin/env bash

set -euo pipefail

cd concourse/helper
docker build -t harbor.lab.home/library/concourse-helper:1 .
docker push harbor.lab.home/library/concourse-helper:1