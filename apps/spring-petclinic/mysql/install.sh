#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install mysql mysql \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 8.4.1 \
--namespace spring-petclinic \
--values helm.yml \
--wait