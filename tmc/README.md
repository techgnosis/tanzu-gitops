Add a user in UAA
Do not give that user any scopes
`tkgi get-kubeconfig cluster1 -u user -a https://tkgi.lab.home`
`kubectl get ns` should be a failure
`kubectl get pods -A` should be a failure
In TMC, assign cluster-admin to user
`kubectl get ns` should work
`kubectl get pods -A` should work


tmc cluster
iam
custom
namespace
security

tmc workspace
iam
image
network

