#! /usr/bin/env bash

set -euo pipefail

cd concourse/helper
cp "$(mkcert -CAROOT)/rootCA.pem" .
docker build -t $HARBOR_DOMAIN/library/concourse-helper:1 .
docker push $HARBOR_DOMAIN/library/concourse-helper:1