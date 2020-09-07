## Context re-do
The goal is to use the Tanzu portfolio to create easy-to-use, low maintenance Kubernetes environments for developers. 

Using Tanzu Mission Control (TMC) and Tanzu Observability (TO) together make it easy to manage large numbers of clusters, so in this repo it is assumed that a cluster is given to each application in each environment. In this situation you need tools to make it easy to manage cluster access and you need tools to help maximize cluster utilization.

TKGI:
* Kubernetes cluster lifecycle platform
* Allows individual cluster upgrades or all-at-once upgrades
TMC:
* Manage cluster access using `cluster-admin`, `admin`, and `edit` roles
* Manage other policy
* Use TO integration to monitor cluster metrics
* Use Data Protection to backup clusters
TO:
* View meaningful application metrics and histograms
* Provide metrics for use in Canary deploy
TBS:
* Build secure OCI images without Docker
* Keep images up-to-date on latest golden image
TAC:
* Build trusted Helm charts and images onto your golden image
* Provide helpful audit information for the images, like CVE scans and open-source licenses

Note: This repo will need some tweaking to work in your environment. See [TODO](#TODO)

## Benefits
* Easy for a single platform team to manage multiple clusters with Tanzu Mission Control
* Change management/auditing - All the infrastructure and application config is in code, including secrets. There is nothing stored in Vault or in S3 somewhere.

## Pre-reqs
* A vanilla Kubernetes cluster
* `helm` to install the Helm operator
* `kapp` to install everything else
* `bash` to run all the install scripts
* `kubectl` and `kubeseal` to create `SealedSecrets`
* `kubectx` for easily changing K8s contexts 
* `mkcert` for all TLS certs

## TKGI steps
1. `./tkgi-create-clusters.sh`
1. `./tkgi-get-credentials.sh`

## TMC steps
1. 1. `./tmc-attach-clusters.sh`

## Harbor
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./secrets-harbor.sh`
1. `./install-harbor.sh`

## TBS
1. `./install-vsphere-storage.sh`
1. `./install-tbs.sh`
1. `./install-tbs-dependencies.sh`
1. `./install-images.sh`

## Concourse
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./secrets-concourse.sh`
1. `./install-concourse.sh`
1. `./install-concourse-main.sh`
1. `./fly.sh`


## spring-petclinic-non-prod
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./install-mysql.sh`
1. `./secrets-spring-petclinic-non-prod.sh`
1. `./install-argo-rollouts.sh`
1. `./install-spring-petclinic-non-prod.sh`

## spring-petclinic-prod
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./install-mysql.sh`
1. `./secrets-spring-petclinic-prod.sh`
1. `./install-argo-rollouts.sh`
1. `./install-spring-petclinic-prod.sh`

## Kubeapps
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./secrets-kubeapps.sh`
1. `./install-kubeapps.sh`
1. `./configure-kubeapps.sh`



### vSphere Storage
Every cluster that has stateful workloads needs a `StorageClass` so that `PersistentVolumes` can be created automatically via `PersistentVolumeClaims`. 

### Sealed Secrets
In the earlier days of Kubernetes, the idea of GitOps famously suffered from the problem of "everything in Git except Secrets". Kubernetes `Secrets` are of course not a secret as they are simply base64 encoded. With the SealedSecrets project, you can use the `kubeseal` CLI to encrypt regular `Secrets` into `SealedSecrets` using a secret key in the cluster. When a `SealedSecret` is applied to a cluster, that secret key is used to decode the `SealedSecret` into a regular `Secret`. Anyone with access to the cluster can still base64 decode the secret.

### Helm Operator
The Helm Operator makes it easy to use Helm while also sticking to a IaC/GitOps mindset. It allows you to use Helm in a declarative sense using `HelmRelease` resources, instead of using Helm in an imperative manner with `helm install`.

### Ingress
Ingress controllers are easier to manage than NodePorts for every app. Use the [Kubernetes in-tree nginx Ingress controller](https://github.com/techgnosis/ingress). It works fine for a lab environment. This implementation uses `hostNetwork: true` to bind port 443 for convenience.

### Harbor
Harbor is an OCI image registry with lots of great security features. Harbor uses the nginx Ingress controller for convenience.

### Tanzu Build Service
Tanzu Build Service (TBS) uses Cloud Native Buildpacks to turn source code into OCI images. TBS has no UI and does not use the Ingress controller.

### Concourse
Concourse is a container-native automation tool commonly used as a "CI/CD" tool. Concourse uses the nginx Ingress controller for convenience.

### Argo Rollouts
Argo Rollouts is a K8s controller that provides Blue/Green and Canary deploys with metrics analysis. Argo Rollouts provides a `Rollout` resource that is used in leiu of a standard `Deployment` resource.


### spring-petclinic
[spring-petclinic](https://github.com/techgnosis/spring-petclinic) is a canonical example of a Spring Boot app. spring-petclinic can use an external MySQL instance instead of its own in-memory DB.

### Kubeapps
Kubeapps is a GUI for Helm that makes it easy to fill out values for Helm charts

## Implementation Notes
* I used an Ubuntu-based image instead of Alpine for the Concourse Helper image. musl behaves strangely sometimes. I was unable to run `ytt` in Alpine. This image is not being downloaded frequently so saving space is not a high priority.


## Wavefront
The Concourse pipeline in this project creates a Wavefront Event after a new image is deployed. In order for this to work, you need to setup Wavefront. Follow these steps to get Wavefront ready:
1. Follow the [Spring Boot Wavefront tutorial](https://docs.wavefront.com/wavefront_springboot_tutorial.html) to get Spring-Petclinic integrated with Wavefront
1. Clone the default dashboard Wavefront creates for you
1. Edit the clone
1. Click "Settings"
1. Click "Advanced"
1. Add the following events query `events(name="tanzu-gitops-spring-petclinic-deploy")`
1. In your dashboard at the top right where it says "Show Events" change it to "From Dashboard Settings". This will cause your events query to be the source of events for all charts in your dashboard.


## TODO
* Use Wavefront to do the analysis during an Argo Rollout
* Learn how to use NSX-T so I don't have to set my ingress controller to `hostNetwork: true` in order to use port 443
* How do you provide a username and password to `tkgi get-credentials` for use with Concourse? Otherwise I get a password prompt when using OIDC. It seems its an environment variable.
* Lots of hardcoded references to `harbor.lab.home` need to be removed
* Can I build Concourse helper without Docker? buildah maybe?

## Wishlist
* Enable TO integration for any cluster added to TMC
* Enable TO integration from the TMC CLI