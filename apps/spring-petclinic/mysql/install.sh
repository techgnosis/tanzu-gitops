#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install mysql mysql \
--repo https://harbor.lab.home/chartrepo/library \
--version 7.1.0 \
--namespace spring-petclinic \
--values helm.yml \
--wait