# MinIO
access key = accesskey
secret key = secretkey

`mc update` - get the latest CLI

The tile docs still say to use `mc config` but that is obviously deprecated. Use `mc alias` instead.

mc alias set tanzu-minio https://minio.lab.home accesskey secretkey

mc ls tanzu-minio

# CSI

kubectl apply -f vsphere-csi-controller-rbac.yml

kubectl apply -f vsphere-csi-controller-ss.yml

kubectl apply -f vsphere-csi-controller-ds.yml
