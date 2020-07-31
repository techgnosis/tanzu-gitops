This repo has all the steps you need to create a modern GitOps style workflow with Kubernetes.

### Pre-reqs
* A vanilla Kubernetes cluster
* A default `StorageClass` resource installed in the cluster

## Installation
The tools used to prepare the cluster are:
* `helm` to install the Helm operator
* `bash` to run all the install scripts
* `kp` CLI to create initial TBS Image resource
* `kubectl` to create Namespaces and Secrets
* `mkcert` for all TLS certs

[INSTALL STEPS](INSTALL.md)

# Stack Overview

### Hardware
AMD EPYC 64-core CPUs

### Hypervisor stack
vSphere

### TKGI
Use [TKGI](https://github.com/techgnosis/tkgi) to provide managed K8s clusters on vSphere or any major cloud provider.

### IdP
IdPs provide a stable user auth service. I use [Okta](https://www.okta.com).

TKGI comes with UAA which, aside from its usual responsibility of federating with a SAML or LDAP IdP, is itself an IdP with its own database and you can use it when needed.

### vRealize Log Insight
vRealize Log Insight provides a log sink for BOSH and all the containers running in any K8s cluster. It is an [easy to install .ova](https://docs.vmware.com/en/vRealize-Log-Insight/index.html).

### Vault
[Vault](https://github.com/techgnosis/vault) or some other secret management tool is needed when managing an environment of any size or complexity. There are too many TLS certs and keys, usernames, passwords, SSH keys, etc, for anyone to keep track of and you can't check them into Git. I'm choosing Vault because it's the most well known of the options.

### Ingress
Ingress controllers are easier to manage than NodePorts for every app. Use the [Kubernetes in-tree nginx Ingress controller](https://github.com/techgnosis/ingress). It works fine for a lab environment. This implementation uses `hostNetwork: true` to bind port 443 for convenience.

### Harbor
[Harbor](https://github.com/techgnosis/harbor2) is an OCI image registry with lots of great security features. Harbor uses the nginx Ingress controller for convenience.

### Concourse
[Concourse](https://github.com/techgnosis/concourse) is a container-native automation tool commonly used as a "CI/CD" tool. Concourse uses the nginx Ingress controller for convenience.

### Tanzu Build Service
[Tanzu Build Service](https://github.com/techgnosis/tanzu-build-service) (TBS) uses Cloud Native Buildpacks to turn source code into OCI images. TBS has no UI and does not use the Ingress controller.

Use TBS to build [Spring PetClinic](https://github.com/spring-projects/spring-petclinic)


### K8s manifests
Your app is defined entirely in [Kubernetes manifests](https://github.com/techgnosis/deploy-petclinic). `kapp` is used to deploy those manifests as part of a Concourse pipeline.


### Service Brokers
[Service brokers](https://github.com/techgnosis/service-brokers) implements the Open Service Broker API (OSBAPI). Brokers create containers for services like MySQL or RabbitMQ and then provide credentials for other containers to use. You can use the [Kubernetes Service Catalog](https://github.com/techgnosis/service-brokers/blob/master/install-service-catalog.sh) to interface with OSBAPI brokers via `kubectl`.

* [KSM](https://github.com/techgnosis/service-brokers/tree/master/ksm) uses Helm to deploy services. Service instances are defined as [offerings](https://github.com/techgnosis/offerings).
* [Minibroker](https://github.com/techgnosis/service-brokers/tree/master/minibroker) is another Helm broker that is a more official part of K8s
* [The official GCP broker](https://github.com/techgnosis/service-brokers/tree/master/gcp) deploys GCP resources



### PetClinic
PetClinic is a good example of a Spring Boot app. Use Flux to monitor the [PetClinic K8s manifests](https://github.com/techgnosis/petclinic) and deploy them

### Tips to make life easier
1. I used Ubuntu instead of Alpine for the Concourse Helper image. musl behaves strangely sometimes. I was unable to run a particular Golang binary in Alpine.


### TODO
* Need to deploy MySQL for PetClinic
* Write Wavefront Concourse task
* How to install everything at once
* How do you provide a username and password to `pks get-credentials` for use with Concourse? Otherwise I get a password prompt when using OIDC
* Switch from nginx to Contour using the Bitnami chart
* Switch to Bitnami for Harbor