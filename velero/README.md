# Velero

`install.sh`

Follow the commented out instructions to fix

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