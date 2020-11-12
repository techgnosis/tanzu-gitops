#! /usr/bin/env bash

set -euo pipefail

if [ -d "tbs-install" ]; then
    rm -rf tbs-install && mkdir tbs-install
fi

if [ ! -d "tbs-install" ]; then
    mkdir tbs-install
fi



tar -xvf build-service-1.0.3.tar -C tbs-install


kbld relocate \
-f ./tbs-install/images.lock \
--lock-output ./tbs-install/images-relocated.lock \
--repository $DOCKERHUB_USERNAME/build-service


kapp deploy -a tanzu-build-service -f <(ytt -f ./tbs-install/values.yaml \
-f ./tbs-install/manifests/ \
-f "$(mkcert -CAROOT)"/rootCA.pem \
-v docker_repository="$DOCKERHUB_USERNAME" \
-v docker_username="$DOCKERHUB_USERNAME" \
-v docker_password="$DOCKERHUB_PASSWORD" \
| kbld -f ./tbs-install/images-relocated.lock -f-)