#! /usr/bin/env bash

set -euo pipefail

docker run -it --rm -p 8089:8089 harbor.lab.home/library/locust:1