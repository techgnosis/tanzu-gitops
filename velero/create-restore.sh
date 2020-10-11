#! /usr/bin/env bash

set -euo pipefail

BACKUP_NUMBER=$1

velero restore create spring-petclinic-restore-$BACKUP_NUMBER \
--from-backup spring-petclinic-$BACKUP_NUMBER