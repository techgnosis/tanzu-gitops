#! /usr/bin/env bash

set -euo pipefail

POSTGRES_DIR="postgres-for-kubernetes-v1.0.0"

if [ -d $POSTGRES_DIR ]; then
    echo "Deleting $POSTGRES_DIR"
    rm -rf $POSTGRES_DIR
fi

tar -xvf postgres-for-kubernetes-v1.0.0.tar.gz

docker load -i $POSTGRES_DIR/images/postgres-instance
docker load -i $POSTGRES_DIR/images/postgres-operator

docker tag postgres-instance:v1.0.0 $HARBOR_DOMAIN/library/postgres-instance:v1.0.0
docker tag postgres-operator:v1.0.0 $HARBOR_DOMAIN/library/postgres-operator:v1.0.0

docker push $HARBOR_DOMAIN/library/postgres-instance:v1.0.0
docker push $HARBOR_DOMAIN/library/postgres-operator:v1.0.0

kapp deploy -a postgres-operator \
-f <(kubectl create secret docker-registry postgres-harbor \
--docker-server="$HARBOR_DOMAIN" \
--docker-username="admin" \
--docker-password="tamale-trauma-coven-guffaw-merger-ted" \
--dry-run=client \
-o yaml)

helm upgrade --install postgres-operator ./$POSTGRES_DIR/operator \
--wait \
--set operatorImageRepository="$HARBOR_DOMAIN/library/postgres-operator" \
--set postgresImageRepository="$HARBOR_DOMAIN/library/postgres-instance" \
--set dockerRegistrySecretName="postgres-harbor"