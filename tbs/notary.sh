#! /usr/bin/env bash

set -euo pipefail

# docker trust inspect harbor.lab.home/library/spring-petclinic

docker trust key generate my-key

docker trust signer add --key my-key.pub my-key $HARBOR_DOMAIN/library/spring-petclinic

kubectl create secret generic spring-petclinic-key \
--namespace images \
--from-literal=password="$REPO_PASSWORD" \
--from-file=$HOME/.docker/trust/private/32eb11c675c043ec34fdb8d23e10be907e8c6d997c0f8ede9460db553448abdd.key
