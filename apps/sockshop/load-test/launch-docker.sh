#! /usr/bin/env bash

set -euo pipefail

docker run -it --rm -p 8089:8089 $HARBOR_DOMAIN/library/sockshop-locust:1