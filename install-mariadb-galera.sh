#! /usr/bin/env bash

set -euo pipefail

helm install mariadb-galera harbor/library/mariadb-galera \
--version 4.4.0 \
--namespace spring-petclinic \
--values manifests/mariadb-galera/values.yml