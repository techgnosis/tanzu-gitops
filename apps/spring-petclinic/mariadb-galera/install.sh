#! /usr/bin/env bash

set -euo pipefail

helm upgrade --install mariadb-galera mariadb-galera \
--repo https://harbor.lab.home/chartrepo/library \
--version 4.4.0 \
--namespace spring-petclinic \
--values helm.yml \
--wait