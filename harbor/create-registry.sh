#! /usr/bin/env bash

set -euo pipefail


curl \
-u admin:Harbor12345 \
-X POST "https://harbor.lab.home/api/v2.0/registries" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d "{ \"credential\": { \"access_key\": \"_json_key\", \"access_secret\": \"\"}, \"name\": \"test\", \"url\": \"https://harbor.lab.home\", \"insecure\": true, \"type\": \"google-gcr\", \"description\": \"TAC\"}"