1. Make cluster
1. Install StorageClass
1. Install [helm operator](https://github.com/techgnosis/helm-operator)
1. Install [TBS](https://github.com/techgnosis/tanzu-build-service)
1. `kapp deploy -a sealed-secrets -f manifests/sealed-secrets`
1. `setup-concourse.sh`
1. `setup-harbor.sh`
1. `setup-spring-petclinic.sh`


1. Relocate the TBS images with `tanzu-build-service/install/relocate.sh`
1. Install TBS with `tanzu-build-service/install/install.sh`
1. `./setup-concourse.sh`
1. `kapp deploy -a concourse -f manifests/concourse`
1. `pipeline/fly.sh`
1. Unpause the pipeline
1. `kapp deploy -a spring-petclinic manifests/spring-petclinic`
1. `kapp deploy -a spring-petclinic-image manifests/spring-petclinic-image`

1. Build and push Concourse Helper with `concourse/Helper/build.sh 1`
1. Install Concourse with `concourse/install/install-concourse.sh`
1. Setup Concourse with `concourse/install/setup.sh`
1. Install the pipeline with `deploy-petclinic/pipeline/fly.sh`
1. Start the pipeline and it should trigger on all Resources and deploy the app