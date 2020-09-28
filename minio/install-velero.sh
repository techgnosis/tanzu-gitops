#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a velero -f <(velero install \
--provider aws \
--plugins velero/velero-plugin-for-aws:v1.0.0 \
--bucket velero \
--secret-file ./credentials-velero \
--use-volume-snapshots=false \
--backup-location-config region=minio,s3ForcePathStyle="true",s3Url=https://minio.lab.home,insecureSkipTLSVerify="true" \
--dry-run \
-o yaml)
