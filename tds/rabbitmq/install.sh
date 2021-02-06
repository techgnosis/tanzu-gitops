#! /usr/bin/env bash

set -euo pipefail

FOLDER="operator-install"

if [ -d "$FOLDER" ]; then
    rm -rf "$FOLDER" && mkdir "$FOLDER"
fi

if [ ! -d "$FOLDER" ]; then
    mkdir "$FOLDER"
fi



tar -xvf tanzu-rabbitMQ-for-kubernetes-1.0.0.tar -C "$FOLDER"

# relocate Tanzu RabbitMQ image
docker pull registry.pivotal.io/rabbitmq/vmware-tanzu-rabbitmq:2020.12
docker tag registry.pivotal.io/rabbitmq/vmware-tanzu-rabbitmq:2020.12 $HARBOR_DOMAIN/library/vmware-tanzu-rabbitmq:2020.12
docker push harbor.lab.home/library/vmware-tanzu-rabbitmq:2020.12

# import the Tanzu operator image
docker import "$FOLDER"/release-artifacts/images/cluster-operator.tar $HARBOR_DOMAIN/library/rabbitmq-cluster-operator:1.4.0
docker push harbor.lab.home/library/rabbitmq-cluster-operator:1.4.0

# Use the Tanzu operator image instead of open-source
sd \
"image: rabbitmqoperator/cluster-operator:1.4.0" \
"image: harbor.lab.home/library/rabbitmq-cluster-operator:1.4.0" \
"$FOLDER"/release-artifacts/manifests/cluster-operator.yml

# install
kapp deploy \
-a tanzu-rabbitmq-operator \
-f $FOLDER/release-artifacts/manifests/cluster-operator.yml
