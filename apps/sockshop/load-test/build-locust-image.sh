#! /usr/bin/env bash

set -euo pipefail

docker build -t harbor.lab.home/library/sockshop-locust:1 .
docker push harbor.lab.home/library/sockshop-locust:1