# Tanzu Demo
The goal of this repo is to demo the use of the Tanzu portfolio to create easy-to-use, low maintenance Kubernetes environments for developers.

Tanzu Kubernetes Grid Integrated Edition:
* Kubernetes cluster lifecycle platform
* Allows individual cluster upgrades or all-at-once upgrades
* Integration with your LDAP or SAML IdP for cluster authentication

Tanzu Misson Control:
* Manage cluster access
* Manage admission and network policy
* Use TO integration to monitor cluster metrics
* Use Data Protection to backup clusters

Tanzu Observability:
* Sole source of metrics for platform teams and application teams
* Show everything from IaaS to K8s to application metrics
* Provide metrics for use in Canary deploy

Tanzu Build Service:
* Build secure OCI images without Docker
* Keep images up-to-date on latest golden image

Tanzu Application Catalog:
* Build trusted Helm charts and images onto your golden image
* Provide helpful audit information for the images, like CVE scans and open-source licenses

Tanzu Application Service:
* Managed multi-tenancy for teams that don't want to touch Kubernetes

### Preparation
1. Copy `.envrc.template` to `.envrc` and fill out all the values
1. Use `direnv` to load those values into your environment

### Pre-reqs
* Ability to make DNS entries for a domain you own
* `tkgi` to create and authenticate to K8s clusters
* `direnv` to handle environment variables
* `helm` to install Helm charts
* `kapp` to install non-Helm software
* `bash` to run all the install scripts
* `kubectl` and `kubeseal` to create `SealedSecrets`
* `mkcert` for all TLS certs (via cert-manager)
* [helm-push](https://github.com/chartmuseum/helm-push)

### Architecture Decisions
* Two clusters. Everything but TAS runs in one cluster. TAS runs in the other cluster.
* This repo is full of default usernames and passwords. It's meant to be easy to setup and use as a demo environment. It's not meant to be a production environment. 
* I use TKGI for my Kubernetes clusters. Most of this project is not dependent on TKGI but the Concourse tasks use the `tkgi` CLI to authenticate
* If a piece of software has a Helm chart, I use the Helm chart
* If a piece of software does not have a Helm chart then I use `ytt` to template and `kapp` to install
* I use environment variables heavily as they are the most portable way to configure software
* Demo environments don't need Lets Encrypt so this project uses `mkcert` which is much easier
* The Concourse tasks are not generic or re-usable. This is to make them easier to read and understand.
* Secrets are handled by `kubeseal` so they can be added to source control. TLS secrets are handled by `cert-manager`



### TKGI
1. `./tkgi-create-clusters.sh`

### TMC steps
1. `./tmc-attach-cluster.sh cluster1`
1. `./tmc-attach-cluster.sh tas`


### cluster1
Inside each of these folders are all the relevant manifests and install scripts. Install them in this order.
1. `sealedsecrets`
1. `storage-vcp` or `storage-csi`
1. `contour` or `nginx-ingress-controller`
1. `cert-manager`
1. `node-exporter`
1. `prometheus`
1. `harbor` or use the Harbor tile
1. `tbs`
1. `images`
1. `concourse`
1. `mariadb-galera`
1. `spring-petclinic`
1. `product-api`
1. `kubeapps` (optional)

### tas
Inside each of these folders are all the relevant manifests and install scripts. Install them in this order.
1. `sealedsecrets`
1. `storage-vcp` or `storage-csi`
1. `minibroker`
1. `tas`

## Component descriptions

### vSphere Storage
Every cluster that has stateful workloads needs a `StorageClass` so that `PersistentVolumes` can be created automatically via `PersistentVolumeClaims`. 

### Sealed Secrets
In the earlier days of Kubernetes, the idea of GitOps famously suffered from the problem of "everything in Git except Secrets". Kubernetes `Secrets` are of course not a secret as they are simply base64 encoded. With the SealedSecrets project, you can use the `kubeseal` CLI to encrypt regular `Secrets` into `SealedSecrets` using a secret key in the cluster. When a `SealedSecret` is applied to a cluster, that secret key is used to decode the `SealedSecret` into a regular `Secret`. Anyone with access to the cluster can still base64 decode the secret.

### Ingress
Ingress controllers are easier to manage than NodePorts for every app. In this project you can choose between Contour and nginx.

### cert-manager
[cert-manager](https://cert-manager.io/docs/) allows you to create certificates as Kubernetes resources. It supports a variety of backends. In this repo we are using `mkcert` as a CA and using cert-manager in CA mode.

### Harbor
Harbor is an OCI image registry with lots of great security features. Harbor uses Trivy to scan your images for CVEs and can prevent images with CVEs from being downloaded.

### Tanzu Build Service
Tanzu Build Service (TBS) uses Cloud Native Buildpacks to turn source code into OCI images. 

### Concourse
Concourse is a container workflow tool commonly used for "CI/CD". Container workflow tools are the "glue" to connect pieces of the software delivery chain together. In this repo Concourse is used to direct a git commit to TBS and then send the resulting image to the Deployment controller.

### spring-petclinic
[spring-petclinic](https://github.com/techgnosis/spring-petclinic) is a canonical example of a Spring Boot app. spring-petclinic uses mariadb-galera for HA MySQL.

### Kubeapps
Kubeapps is a GUI for Helm that makes it easy to explore Helm repos

### Wavefront
The Concourse pipeline in this project creates a Wavefront Event after a new image is deployed. In order for this to work, you need to setup Wavefront. Follow these steps to get Wavefront ready:
1. Follow the [Spring Boot Wavefront tutorial](https://docs.wavefront.com/wavefront_springboot_tutorial.html) to get Spring-Petclinic integrated with Wavefront
1. Clone the default dashboard Wavefront creates for you
1. Edit the clone
1. Click "Settings"
1. Click "Advanced"
1. Add the following events query `events(name="tanzu-gitops-spring-petclinic-deploy")`
1. In your dashboard at the top right where it says "Show Events" change it to "From Dashboard Settings". This will cause your events query to be the source of events for all charts in your dashboard.


## Quirks I have observed
* Kubeapps only seems to behave if it is installed in the `default` namespace. Otherwise it doesn't recognize App Respositories when you try to install anything in a different namespace than `default`.


## Potentially helpful Prometheus queries
I'll switch to Grafana eventually but I need to get a better grasp of the metrics
* `rate(node_network_receive_bytes_total{device="eth0"}[1m])`
* `rate(node_cpu_seconds_total{mode="user"}[1m])`
* `node_memory_MemFree_bytes`
* `node_memory_Active_bytes`

## TODO
* Get TSMgr added to project
* Change project name from `tanzu-gitops` to something else
* Add Tekton pipelines
* Add a pipeline to get test-app into TAS
* When using OIDC for K8s auth, how do you provide a username and password to `tkgi get-credentials` for use with Concourse? Otherwise I get a password prompt when using OIDC. It seems its an environment variable.