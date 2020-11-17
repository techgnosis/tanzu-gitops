#! /usr/bin/env bash

source ./demo-magic.sh

p 'Granting access to the whole cluster for a "devops" person'
pe 'tkgi get-kubeconfig cluster1 --username devops --password devops --api https://tkgi.lab.home'
pe 'kubectl get ns'
pe 'kubectl get pods -n spring-petclinic'
pe 'kubectl get pods -n sockshop'
p 'Lets grant access in TMC'
pe 'kubectl get ns'
pe 'kubectl get pods -n spring-petclinic'
pe 'kubectl get pods -n sockshop'

p 'Granting access to the sockshop namespace for a sockshop dev'
pe 'tkgi get-kubeconfig cluster1 --username sockshop-dev --password sockshop-dev --api https://tkgi.lab.home'
pe 'kubectl get ns'
pe 'kubectl get pods -n spring-petclinic'
pe 'kubectl get pods -n sockshop'
p 'Lets grant access in TMC'
pe 'kubectl get ns'
pe 'kubectl get pods -n spring-petclinic'
pe 'kubectl get pods -n sockshop'

p 'Granting access to the spring-petclinic namespace for a spring-petclinic dev'
pe 'tkgi get-kubeconfig cluster1 --username spring-petclinic-dev --password spring-petclinic-dev --api https://tkgi.lab.home'
pe 'kubectl get ns'
pe 'kubectl get pods -n spring-petclinic'
pe 'kubectl get pods -n sockshop'
p 'Lets grant access in TMC'
pe 'kubectl get ns'
pe 'kubectl get pods -n spring-petclinic'
pe 'kubectl get pods -n sockshop'


