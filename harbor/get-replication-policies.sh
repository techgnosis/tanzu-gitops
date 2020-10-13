#! /usr/bin/env bash

set -euo pipefail


curl \
-u admin:Harbor12345 \
-X GET "https://harbor.lab.home/api/v2.0/replication/policies" \
-H "accept: application/json" \
-H "Content-Type: application/json"