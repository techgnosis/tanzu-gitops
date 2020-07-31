1. Starting with a new cluster with a default StorageClass
1. `helm-operator/install.sh`
1. `kapp deploy -a sealed-secrets -f manifests/sealed-secrets`
1. `./setup-secrets.sh`
1. `kapp deploy -a ingress-nginx -f manifests/ingress-nginx`
1. `kapp deploy -a harbor -f manifests/harbor`
1. Install [TBS](https://github.com/techgnosis/tanzu-build-service)
1. `kapp deploy -a concourse -f manifests/concourse`
1. Build and push Concourse Helper with `cd concourse/Helper && ./concourse/Helper/build.sh 1`
1. `setup-pipeline-secrets.sh`
1. `kapp deploy -a concourse-secrets -f manifests/concourse-main`
1. `cd concourse/pipeline`
1. `./fly.sh`
1. Unpause the pipeline