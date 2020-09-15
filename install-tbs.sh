#! /usr/bin/env bash

set -euo pipefail

if [ -d "tbs-install" ]; then
    rm -rf tbs-install && mkdir tbs-install
fi

tar -xvf build-service-1.0.2.tar -C tbs-install


kbld relocate \
-f ./tbs-install/images.lock \
--lock-output ./tbs-install/images-relocated.lock \
--repository "$HARBOR_DOMAIN/library/build-service"


ytt -f ./tbs-install/values.yaml \
-f ./tbs-install/manifests/ \
-f "$(mkcert -CAROOT)"/rootCA.pem \
-v docker_repository="$HARBOR_DOMAIN/library/build-service" \
-v docker_username="admin" \
-v docker_password="Harbor12345" \
| kbld -f ./tbs-install/images-relocated.lock -f- \
| kapp deploy -a tanzu-build-service -f- -y