#! /usr/bin/env bash

set -euo pipefail

docker build -t $HARBOR_DOMAIN/library/locust:1 .
docker push $HARBOR_DOMAIN/library/locust:1