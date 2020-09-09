The goal of this repo is to use the Tanzu portfolio to create easy-to-use, low maintenance Kubernetes environments for developers.

TKGI:
* Kubernetes cluster lifecycle platform
* Allows individual cluster upgrades or all-at-once upgrades
* Integration with your LDAP or SAML IdP for cluster authentication
TMC:
* Manage cluster access
* Manage admission and network policy
* Use TO integration to monitor cluster metrics
* Use Data Protection to backup clusters
TO:
* Sole source of metrics for platform teams and application teams
* Show everything from IaaS to K8s to application metrics
* Provide metrics for use in Canary deploy
TBS:
* Build secure OCI images without Docker
* Keep images up-to-date on latest golden image
TAC:
* Build trusted Helm charts and images onto your golden image
* Provide helpful audit information for the images, like CVE scans and open-source licenses
TAS4K8s:
* Managed multi-tenancy for small stateless applications too small for a dedicated cluster

Note: This repo will need some tweaking to work in your environment. I tried to keep things as portable as possible but mistakes were made.

## Pre-reqs (to use my code as-is)
* Ability to make DNS entries for a domain you own
* TKGI installed on vSphere
* You have at least `pks.clusters.manage` scope
* A VSAN datastore named `vsanDatastore`
* `direnv` to handle environment variables
* `tkgi` to create Kubernetes clusters
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


## spring-petclinic
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./install-mysql.sh`
1. `./install-argo-rollouts.sh`
1. `./secrets-spring-petclinic.sh`
1. `./install-spring-petclinic.sh`

## product-api
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./install-argo-rollouts.sh`
1. `./secrets-product-api.sh`
1. `./install-product-api.sh`

## Kubeapps
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./secrets-kubeapps.sh`
1. `./install-kubeapps.sh`
1. `./configure-kubeapps.sh`

## TAS4K8s
1. `./install-vsphere-storage.sh`
1. `./install-helm-operator.sh`
1. `./install-minibroker.sh`
1. `./install-tas4k8s.sh`
1. `./configure-tas.sh`



### vSphere Storage
Every cluster that has stateful workloads needs a `StorageClass` so that `PersistentVolumes` can be created automatically via `PersistentVolumeClaims`. 

### Sealed Secrets
In the earlier days of Kubernetes, the idea of GitOps famously suffered from the problem of "everything in Git except Secrets". Kubernetes `Secrets` are of course not a secret as they are simply base64 encoded. With the SealedSecrets project, you can use the `kubeseal` CLI to encrypt regular `Secrets` into `SealedSecrets` using a secret key in the cluster. When a `SealedSecret` is applied to a cluster, that secret key is used to decode the `SealedSecret` into a regular `Secret`. Anyone with access to the cluster can still base64 decode the secret.

### Helm Operator
The Helm Operator makes it easy to use Helm while also sticking to an infrastructure-as-code/GitOps mindset. It allows you to use Helm in a declarative sense using `HelmRelease` resources, instead of using Helm in an imperative manner with `helm install`. This also allows best practices of using Helm to be used without anyone having to learn them since those best practices are captured in the custom Kubernetes controller.

### Ingress
Ingress controllers are easier to manage than NodePorts for every app. Use the [Kubernetes in-tree nginx Ingress controller](https://github.com/techgnosis/ingress). It works fine for a lab environment. This implementation uses `hostNetwork: true` to bind port 443 for convenience.

### Harbor
Harbor is an OCI image registry with lots of great security features. Harbor uses Trivy to scan your images for CVEs and can prevent images with CVEs from being downloaded.

### Tanzu Build Service
Tanzu Build Service (TBS) uses Cloud Native Buildpacks to turn source code into OCI images. TBS has no UI and does not use the Ingress controller.

### Concourse
Concourse is a container workflow tool commonly used for "CI/CD". Container workflow tools are the "glue" to connect pieces of the software delivery chain together. In this repo it is used to validate a git commit before telling Tanzu Build Service to build that commit and begin its lifecycle. Validation consists of running tests and checkstyle with maven but could be as in-depth as your organization requires.

### Argo Rollouts
Argo Rollouts is a K8s controller that provides Blue/Green and Canary deploys with metrics analysis. Argo Rollouts provides a `Rollout` resource that is used in leiu of a standard `Deployment` resource.


### spring-petclinic
[spring-petclinic](https://github.com/techgnosis/spring-petclinic) is a canonical example of a Spring Boot app. spring-petclinic can use an external MySQL instance instead of its own in-memory DB.

### Kubeapps
Kubeapps is a GUI for Helm that makes it easy to fill out values for Helm charts

## Quirks I have observed
* I used an Ubuntu-based image instead of Alpine for the Concourse Helper image. musl behaves strangely sometimes. I was unable to run `ytt` in Alpine.
* Kubeapps only seems to behave if it is installed in the `default` namespace


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
* Test out the Bitnami Contour chart again
* Pipeline with PivNet resource that downloads and applies new TBS stacks
* Adopt cert-manager for more declarative TLS
* Need to find best practices for image promotion
* Use Wavefront to do the analysis during an Argo Rollout
* Learn how to use NSX-T so I don't have to set my ingress controller to `hostNetwork: true` in order to use port 443
* How do you provide a username and password to `tkgi get-credentials` for use with Concourse? Otherwise I get a password prompt when using OIDC. It seems its an environment variable.
* Lots of hardcoded references to `harbor.lab.home` need to be removed