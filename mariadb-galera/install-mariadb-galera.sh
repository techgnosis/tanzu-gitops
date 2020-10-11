#! /usr/bin/env bash

set -euo pipefail

helm install mariadb-galera mariadb-galera \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 4.4.0 \
--namespace spring-petclinic \
--create-namespace \
--values helm.yml \
--wait