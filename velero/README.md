# Velero

`install-velero-cli.sh` works

`install-velero-helm.sh` does not quite work. I can't figure out how to get the CA Cert part to work.


### MinIO 
MinIO is installed on K8s at https://minio.lab.home

### Update `mc` client
`mc update`

### Configure MinIO server
`mc alias set tanzu-minio https://minio.lab.home accesskey secretkey`

### List buckets
`mc ls tanzu-minio`

### Make bucket
`mc mb tanzu-minio <bucketname>`