#! /usr/bin/env bash

set -euo pipefail

echo 'BACKUP_NUMBER=$1'

BACKUP_NUMBER=$1

velero backup create spring-petclinic-$BACKUP_NUMBER \
--include-namespaces=spring-petclinic