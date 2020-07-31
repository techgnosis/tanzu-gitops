There are a few ways to manage supporting infrastructure in a GitOps manner:
1. Handwritten YAML that is deployed like all your other K8s manifests
1. `helm template` to disk and then commit it to Git
1. Only track the helm chart version in Git
1. Custom operators, with CRDs checked into Git
1. The Helm operator

The Helm operator lets you use CRDs to manage Helm releases, which is the best of both worlds. You get the huge ecosystem of Helm charts with the everything-in-git goodness of a GitOps workflow.

Per the helm-operator GitHub, the Helm controller will replace it one day
https://github.com/fluxcd/helm-controller

# GitOps Toolkit
https://toolkit.fluxcd.io/
