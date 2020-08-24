## Context
The Kubernetes ecosystem can be overwhelming. There are hundreds of open-source projects all building tools for the Kubernetes ecosystem. How do you put all these tools together? There are endless combinations and every solution will have its pros and cons. Some solutions might be focused on a platform team and their needs, while other solutions might be focused on how application developers can be most productive in Kubernetes. This repo is focused on application developers and aims to prescribe a set of tools that together create an effective development environment.

The solution installed via this repo is a classic "GitOps" workflow. GitOps is the next evolution of Infrastructure-as-Code. With GitOps, 100% of your infrastructure is in code and you use standard Git workflows like GitHub Pull Requests to make changes to your infrastructure. The Git repo containing your infrastructure code is constantly monitored by a tool that syncs the state in the repo with the Kubernetes cluster.

Usage of this repo requires two clusters: an "infra" cluster for things like Concourse and Harbor, as well as a "workload" cluster for the app itself (spring-petclinic) as well as the supporting MySQL database.

Note: This repo will need some tweaking to work in your environment. See [TODO](#TODO)

## Benefits
There is no point in focusing on the tools themselves. Instead, focus on what the tools let you achieve. In no particular order, here are the benefits you gain from using a GitOps style workflow:
* All the infrastructure and application config is in code, including secrets. There is nothing stored in Vault or in S3 somewhere. 

## Pre-reqs
* A vanilla Kubernetes cluster
* `helm` to install the Helm operator
* `kapp` to install everything else
* `bash` to run all the install scripts
* `kubectl` and `kubeseal` to create `SealedSecrets`
* `mkcert` for all TLS certs

## Installation
While pointing at your infrastructure cluster
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
1. `./build-adoptopenjdk-image.sh`
1. `./build-concourse-helper.sh`
1. `./install-concourse-main.sh`
1. `./fly.sh`


While pointing at your workloads cluster
1. `./install-vsphere-storage.sh`
1. `./install-sealedsecrets.sh`
1. `./setup-workload-secrets.sh`
1. `./install-helm-operator.sh`
1. `./install-ingress-nginx.sh`
1. `./install-mysql.sh`
1. `./install-spring-petclinic.sh`
1. Unpause the pipeline


### vSphere Storage
Every cluster that has stateful workloads needs a `StorageClass` to that `PersistentVolumes` can be created automatically via `PersistentVolumeClaims`. 

### Sealed Secrets
In the earlier days of Kubernetes, the idea of GitOps famously suffered from the problem of "everything in Git except Secrets". Kubernetes `Secrets` are of course not a secret as they are simply base64 encoded. With the SealedSecrets project, you can use the `kubeseal` CLI to encrypt regular `Secrets` into `SealedSecrets` using a secret key in the cluster. When a `SealedSecret` is applied to a cluster that secret key is used to decode the `SealedSecret` into a regular `Secret`. Anyone with access to the cluster can still base64 decode the secret.

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


### spring-petclinic
[spring-petclinic](https://github.com/techgnosis/spring-petclinic) is a canonical example of a Spring Boot app. spring-petclinic can use an external MySQL instance instead of its own in-memory DB.

## Implementation Notes
* I used Ubuntu instead of Alpine for the Concourse Helper image. musl behaves strangely sometimes. I was unable to run a particular Golang binary in Alpine.


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
* Capture all needed changes in spring-petclinic in a patch file. Be able to start from scratch anytime
* How do you provide a username and password to `pks get-credentials` for use with Concourse? Otherwise I get a password prompt when using OIDC. It seems its an environment variable.
* Lots of hardcoded references to `harbor.lab.home` need to be removed
* Combine adoptopenjdk image and concourse-helper image
* vSphere Storage manifest has a hardcoded reference to one of my datastores
* Use kapp-controller instead of helm-operator
* Switch from nginx to either Contour or a mesh
* Switch to ytt instead of sd
* Create more specific Concourse resources for spring-petclinic and mysql, instead of the whole tanzu-gitops repo