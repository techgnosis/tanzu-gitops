# MinIO
MinIO is installed on K8s

### Update `mc` client
`mc update`

### Configure MinIO server
`mc alias set tanzu-minio https://minio.lab.home accesskey secretkey`

### List buckets
`mc ls tanzu-minio`

### Make bucket
`mc mb tanzu-minio <bucketname>`