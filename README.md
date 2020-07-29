Everything you need to deploy the Tanzu Lab application. Tanzu Lab is made up of Spring PetClinic and some other service I haven't decided on yet.

`setup.sh` - creates the Namespace, creates a TLS secret for Ingress, creates a Registry secret for TBS, and creates the TBS Images for PetClinic and the other service

`manifests` - all the K8s manifests to deploy Tanzu Lab

`pipeline` - all the files needed to create the pipeline for Tanzu Lab.