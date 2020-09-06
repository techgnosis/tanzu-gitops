## Context
The Kubernetes ecosystem can be overwhelming. There are hundreds of open-source projects all building tools for the Kubernetes ecosystem. How do you put all these tools together? There are endless combinations and every solution will have its pros and cons. Some solutions might be focused on a platform team and their needs, while other solutions might be focused on how application developers can be most productive in Kubernetes. This repo is focused on using the VMware Tanzu portfolio of products to build repeatable, low maintenance Kubernetes environments for your development teams.

On the 'platform' side, we use Tanzu Mission Control as the primary interface and allows you to manage policy for namespaces and clusters as well as interface with Tanzu Observability to see in-depth Kubernetes cluster metrics. The clusters themselves come with some tools that would also be considered "platform", like an Ingress controller, the SealedSecrets controller, and any other software that would need custom RBAC. The goal is to provide a development team with everything they need so that they are unhindered by the 'edit' ClusterRole with a namespaced RoleBinding.

On the 'application' side of things, Tanzu Observability is used as the primary interface and allows you to build meaningful queries from a wide variety of metrics sources. We use spring-petclinic as the demo application. spring-petclinic is a canonical example of a Spring Boot application. spring-petclinic is built into a secure image and kept up-to-date using Tanzu Build Service. The image is stored and vulnerability scanned in Harbor image registry. It is deployed using the Argo Rollouts controller that does Canary deploys with live metric analysis from Tanzu Observability. spring-petclinic uses a MySQL database installed via a Helm chart sourced from Tanzu Application Catalog, which harnesses the open-source expertise of Bitnami to build popular open-source software onto your golden base image and provides audit information such as open-source licenses and CVE scans.

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
* `mkcert` for all TLS certs

## Installation
While pointing at your infrastructure cluster
1. `./attach-cluster1.sh`
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./setup-infra-secrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./install-harbor.sh`
1. `./install-tbs.sh`
1. `./install-tbs-dependencies.sh`
1. `./install-images.sh`
1. `./install-concourse.sh`
1. `./build-concourse-helper.sh`
1. `./install-concourse-main.sh`
1. `./fly.sh`
1. commit and push the new `SealedSecrets`


While pointing at your workloads cluster
1. `./attach-cluster2.sh`
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./setup-workload-secrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./install-mysql.sh`
1. `./install-argo-rollouts.sh`
1. `./install-spring-petclinic.sh`
1. `./install-kubeapps.sh`
1. commit and push the new `SealedSecrets`
1. Unpause the pipeline


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
1. Cliick "Settings"
1. Click "Advanced"
1. Add the following events query `events(name="tanzu-gitops-spring-petclinic-deploy")`
1. In your dashboard at the top right where it says "Show Events" change it to "From Dashboard Settings". This will cause your events query to be the source of events for all charts in your dashboard.


## TODO
* Use Wavefront to do the analysis during an Argo Rollout
* Learn how to use NSX-T so I don't have to set my ingress controller to `hostNetwork: true` in order to use port 443
* How do you provide a username and password to `tkgi get-credentials` for use with Concourse? Otherwise I get a password prompt when using OIDC. It seems its an environment variable.
* Lots of hardcoded references to `harbor.lab.home` need to be removed
* vSphere Storage manifest has a hardcoded reference to one of my datastores
* Can I build Concourse helper without Docker? buildah maybe?