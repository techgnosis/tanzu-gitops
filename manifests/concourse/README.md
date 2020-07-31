### Notes
1. Your K8s cluster MUST support privileged containers. Concourse workers need to run as privileged containers.
1. This install uses an Ingress to receive traffic
1. [Concourse Helm chart docs](https://github.com/concourse/concourse-chart)

### Username and password
`test` and `test`

### Vault
Use the newer [var_sources](https://concourse-ci.org/vars.html#var-sources) functionality so new sources of secrets can be configured with YAML at the pipeline level instead of with flags during Concourse install.