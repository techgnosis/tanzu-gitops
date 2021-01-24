#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a velero -f <(velero install \
--provider aws \
--plugins velero/velero-plugin-for-aws:v1.1.0,velero/velero-plugin-for-csi:v0.1.0 \
--bucket velero \
--secret-file ./credentials-velero \
--features=EnableCSI \
--use-volume-snapshots=true \
--backup-location-config region=minio,s3ForcePathStyle="true",s3Url=https://minio.lab.home \
--cacert "$(mkcert -CAROOT)/rootCA.pem" \
--dry-run \
-o yaml)

#velero client config set features=EnableCSI