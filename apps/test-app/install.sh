#! /usr/bin/env bash

set -euo pipefail

if [ ! -d "test-app" ]; then
    git clone https://github.com/cloudfoundry-samples/test-app.git
fi

cf push test-app -p test-app
curl "https://test-app.apps.$SYSTEM_DOMAIN"