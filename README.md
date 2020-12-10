# Tanzu Demo
The goal of this repo is to store ready-to-install manifests for Tanzu products as well as popular open-source Kubernetes tools. From here you can demo any functionality you need.

* Building source-to-image with Tanzu Build Service
* Using Helm in an airgapped scenario with Tanzu Application Catalog and Harbor
* Harbor is an OCI compliant registry with tons of features
* Self-service TLS certificates with cert-manager
* CI+CD with Concourse
* Ingress with either nginx or Contour
* Quickly explore Helm values.yml files with Kubeapps
* Metrics with Prometheus + node-exporter + cAdvisor + Grafana
* Backup and restore both etcd and PVs with Velero + Restic
* Store secrets in Git with Sealed Secrets
* Store secrets outside of the cluster with Vault
* Manage policy across all your clusters with Tanzu Mission Control
* Turn a K8s cluster into a multi-tenant microservice host with Tanzu Application Service
* Store objects, including Velero backups, in MinIO


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

### Architecture Decisions
* Two clusters. Everything but TAS runs in one cluster. TAS runs in the other cluster.
* This repo is full of default usernames and passwords. It's meant to be easy to setup and use as a demo environment. It's not meant to be a production environment. 
* I use TKGI for my Kubernetes clusters. Most of this project is not dependent on TKGI but the Concourse tasks use the `tkgi` CLI to authenticate
* If a piece of software has a Helm chart, I use the Helm chart
* If a piece of software does not have a Helm chart then I use `ytt` to template and `kapp` to install
* I use environment variables heavily
* Demo environments don't need Lets Encrypt so this project uses `mkcert` which is much easier
* The Concourse tasks are not generic or re-usable. This is to make them easier to read and understand.
* Secrets are handled by `kubeseal` so they can be added to source control. TLS secrets are handled by `cert-manager`



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


## Potentially helpful Prometheus queries
I'll switch to Grafana eventually but I need to get a better grasp of the metrics
* `rate(node_network_receive_bytes_total{device="eth0"}[1m])`
* `rate(node_cpu_seconds_total{mode="user"}[1m])`
* `node_memory_MemFree_bytes`
* `node_memory_Active_bytes`

## TODO
* Cut down on the size of .envrc. Don't need an entry for every app.
* Change project name from `tanzu-gitops` to `tanzu-demo` and make all required code changes
* Drop SealedSecrets. It's cool but it's not adding anything to this repo
* Change Harbor password back to Harbor12345
* Consolidate demo.sh scripts into one mega demo