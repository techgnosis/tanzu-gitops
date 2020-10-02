#! /usr/bin/env bash

set -euo pipefail

kapp deploy \
-a mariadb-galera \
--into-ns=spring-petclinic \
-f <(helm template mariadb-galera harbor/library/mariadb-galera \
--version 4.4.0 \
--values manifests/mariadb-galera/values.yml)