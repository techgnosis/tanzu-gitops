#! /usr/bin/env bash

set -euo pipefail

docker run --rm -it -p 8089:8089 acme_fitness_traffic /root/start.sh