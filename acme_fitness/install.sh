#! /usr/bin/env bash

set -euo pipefail

K8S_PATH=acme_fitness_demo/kubernetes-manifests

kapp deploy \
-a acme-fitness \
--into-ns acme-fitness \
-f <(kubectl create secret generic cart-redis-pass \
--from-literal=password=acmefitness \
--dry-run=client \
-o yaml) \
-f $K8S_PATH/cart-redis-total.yaml \
-f $K8S_PATH/cart-total.yaml \
-f <(kubectl create secret generic catalog-mongo-pass \
--from-literal=password=acmefitness \
--dry-run=client \
-o yaml) \
-f $K8S_PATH/catalog-db-initdb-configmap.yaml \
-f $K8S_PATH/catalog-db-total.yaml \
-f $K8S_PATH/catalog-total.yaml \
-f $K8S_PATH/payment-total.yaml \
-f <(kubectl create secret generic order-postgres-pass \
--from-literal=password=acmefitness \
--dry-run=client \
-o yaml) \
-f $K8S_PATH/order-db-total.yaml \
-f $K8S_PATH/order-total.yaml \
-f <(kubectl create secret generic users-mongo-pass \
--from-literal=password=acmefitness \
--dry-run=client \
-o yaml) \
-f <(kubectl create secret generic users-redis-pass \
--from-literal=password=acmefitness \
--dry-run=client \
-o yaml) \
-f $K8S_PATH/users-db-initdb-configmap.yaml \
-f $K8S_PATH/users-db-total.yaml \
-f $K8S_PATH/users-redis-total.yaml \
-f $K8S_PATH/users-total.yaml \
-f $K8S_PATH/frontend-total.yaml \
-f $K8S_PATH/point-of-sales-total.yaml
