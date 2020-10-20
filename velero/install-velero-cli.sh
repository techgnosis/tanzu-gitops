#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a velero -f <(velero install \
--provider aws \
--plugins velero/velero-plugin-for-aws:v1.1.0 \
--bucket velero \
--secret-file ./credentials-velero \
--use-volume-snapshots=false \
--cacert "$(mkcert -CAROOT)/rootCA.pem" \
--backup-location-config region=minio,s3ForcePathStyle="true",s3Url=https://minio.lab.home,insecureSkipTLSVerify="true" \
--dry-run \
--use-restic \
-o yaml)


# kubectl patch daemonset restic \
# --namespace velero \
# --type='json' \
# --patch='[{"op": "replace", "path": "/spec/template/spec/containers/0/volumes/0/hostPath/path", "value":"/var/vcap/data/kubelet/pods"}]'