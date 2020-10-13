#! /usr/bin/env bash

set -euo pipefail


curl \
-u admin:Harbor12345 \
-X POST \
"https://harbor.lab.home/api/v2.0/replication/policies" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-H "X-Harbor-CSRF-Token: y2QXnvUYFjFBPopv/pCGJ1VLQ5e/VVOlZmKah7vKGARnJkW67pqtz1JT5b4KY27dpsK6tySjKVrH3YZ1Gc2fsA==" \
-d @replication-policy.json