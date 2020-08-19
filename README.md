The goal of this repo is to show how you can create a high functioning K8s development environment for your development teams. You will deploy software to two clusters: an "infra" cluster for things like Concourse and Harbor, as well as a "workload" cluster for the app itself (spring-petclinic) as well as the supporting MySQL database.

GitOps is the next evolution of Infrastructure-as-Code. With GitOps, 100% of your infrastructure is in code and you use standard Git workflows like GitHub Pull Requests to make changes to your infrastructure. The Git repo containing your infrastructure code is constantly monitored by a tool that syncs the state in the repo with the Kubernetes cluster.

In this repo we have chosen Concourse to sync the Git state with the Kubernetes cluster. There are popular tools like Flux and Argo that can do this for us but I wanted to get a better idea of how to use `kapp` which Concourse uses to do all the actual deploying.

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
1. I used Ubuntu instead of Alpine for the Concourse Helper image. musl behaves strangely sometimes. I was unable to run a particular Golang binary in Alpine.


## Wavefront
The Concourse pipeline in this project creates a Wavefront Event after a new image is deployed. In order for this to work, you need to setup Wavefront. Follow these steps to get Wavefront ready:
1. Follow the Spring Boot Wavefront tutorial to get Spring-Petclinic integrated with Wavefront
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