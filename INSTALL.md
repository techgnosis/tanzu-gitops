1. Make cluster
1. Install StorageClass
1. Install nginx with `ingress/nginx/install.sh`
1. Install Harbor with `harbor/install.sh standalone`
1. Make a TBS project in Harbor
1. Relocate the TBS images with `tanzu-build-service/install/relocate.sh`
1. Install TBS with `tanzu-build-service/install/install.sh`
1. Happened once: default TBS builder failed to create.
1. Prepare `petclinic` namespace and build first image with `deploy-petclinic/setup.sh`
1. Build and push Concourse Helper with `concourse/Helper/build.sh 1`
1. Install Concourse with `concourse/install/install-concourse.sh`
1. Setup Concourse with `concourse/install/setup.sh`
1. Install the pipeline with `deploy-petclinic/pipeline/fly.sh`
1. Start the pipeline and it should trigger on all Resources and deploy the app