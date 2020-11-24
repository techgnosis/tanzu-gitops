#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install mysql mysql \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 7.1.0 \
--namespace spring-petclinic \
--create-namespace \
--values helm.yml \
--wait