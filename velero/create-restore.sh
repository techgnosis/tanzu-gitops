#! /usr/bin/env bash

set -euo pipefail

echo 'BACKUP_NUMBER=$1'
echo 'RESTORE_NUMBER=$2'

BACKUP_NUMBER=$1
RESTORE_NUMBER=$2



velero restore create spring-petclinic-restore-$RESTORE_NUMBER \
--from-backup spring-petclinic-$BACKUP_NUMBER