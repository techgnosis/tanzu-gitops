# Tanzu Demo
The goal of this repo is to store ready-to-install manifests for Tanzu products as well as popular open-source Kubernetes tools. From here you can demo any functionality you need.

* Building source-to-image with Tanzu Build Service
* Using Helm in an airgapped scenario with Tanzu Application Catalog and Harbor
* Harbor is an OCI compliant registry with tons of features
* Self-service TLS certificates with cert-manager
* CI+CD with Concourse
* Ingress and mesh with Istio
* Quickly explore Helm repos Kubeapps
* Cluster metrics with Tanzu Observability
* Backup and restore both etcd and PVs with Velero + Restic
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


## Component descriptions

### vSphere Storage
Every cluster that has stateful workloads needs a `StorageClass` so that `PersistentVolumes` can be created automatically via `PersistentVolumeClaims`. 

### Service Mesh
Istio can be used both for Ingress as well as sidecar proxying.

### cert-manager
[cert-manager](https://cert-manager.io/docs/) allows you to create certificates as Kubernetes resources. It supports a variety of backends. In this repo we are using `mkcert` as a CA and using cert-manager in CA mode.

### Harbor
Harbor is an OCI image registry with lots of great security features. Harbor uses Trivy to scan your images for CVEs and can prevent images with CVEs from being downloaded.

### Tanzu Build Service
Tanzu Build Service (TBS) uses Cloud Native Buildpacks to turn source code into OCI images. 

### Concourse
Concourse is a container workflow tool commonly used for "CI/CD". Container workflow tools are the "glue" to connect pieces of the software delivery chain together. In this repo Concourse is used to direct a git commit to TBS and then send the resulting image to the Deployment controller.

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
* Concourse Helm chart uses deprecated RBAC and uses Docker Hub. Use a newer Helm chart