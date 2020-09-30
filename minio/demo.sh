#! /usr/bin/env bash

source ./demo-magic.sh

BACKUP_NUMBER=$1

pe 'mc alias list'


pe 'mc tree tanzu-minio'

p 'velero install \
--provider aws \
--plugins velero/velero-plugin-for-aws:v1.0.0 \
--bucket velero \
--secret-file ./credentials-velero \
--use-volume-snapshots=false \
--backup-location-config region=minio,s3ForcePathStyle="true",s3Url=https://minio.lab.home,insecureSkipTLSVerify="true"'

pe "velero backup create spring-petclinic-$BACKUP_NUMBER \
--include-namespaces=spring-petclinic \
--snapshot-volumes \
--volume-snapshot-locations vsl-vsphere"

pe "watch velero backup describe spring-petclinic-$BACKUP_NUMBER"

pe 'mc tree tanzu-minio'

pe "mc ls tanzu-minio/velero/backups/spring-petclinic-$BACKUP_NUMBER"