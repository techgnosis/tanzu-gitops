#! /usr/bin/env bash

set -euo pipefail

cd traffic-generation
docker build -t harbor.lab.home/library/locust:1 .
docker push harbor.lab.home/library/locust:1