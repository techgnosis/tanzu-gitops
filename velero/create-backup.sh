#! /usr/bin/env bash

set -euo pipefail

BACKUP_NUMBER=$1

velero backup create spring-petclinic-$BACKUP_NUMBER \
--include-namespaces=spring-petclinic \
--snapshot-volumes \
--volume-snapshot-locations vsl-vsphere