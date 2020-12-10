#! /usr/bin/env bash

source ./demo-magic.sh

# How to reset
# Delete MySQL with Helm and spring-petclinic with kapp
# Delete the PVC in spring-petclinic
# Delete the spring-petclinic namespace from TMC UI
# Reset TBS back to 19
# Delete all the MySQL and common Helm charts

#1 - secure image pipeline for existing software
#2 - platform operators providing databases and K8s access to development teams with TAC and TMC
#3 - low-K8s "easy mode"
#4 - microservices architecture
#5 - constant backdrop of observability


clear

p 'Welcome. Lets get started by showing an existing pipeline being triggered by a code change'
pe 'kp build logs product-api -n images'
p 'Lets take a look at the image YAML'
pe 'bat images/product-api.yml'

p 'But what about keeping the images up-to-date?'
pe 'tbs/tbs-update-stack-100.0.30.sh'
pe 'kp build logs product-api -n images'


p 'Lets add a new Spring Boot application to our environment. The app is called spring-petclinic'
p 'First we need a database'
p 'Next step is to put the MySQL chart into Harbor'
cd tac
pe './sync.sh'
cd ..
p 'Lets take a look at Harbor Helm repo and our image replication'


p 'Helm repo is ready. We need to provision a new namespace for our application. Lets use Tanzu Mission Control'
p 'Lets login as our spring-petclinic developer and begin deploying'
pe 'tkgi get-kubeconfig cluster2 --username spring-petclinic-dev --password spring-petclinic-dev --api https://tkgi.lab.home'
p 'We havent been assigned any permissions yet. Lets confirm'
pe 'kubectl get pods -n product-api'
pe 'kubectl get pods -n spring-petclinic'
cd apps/spring-petclinic/mysql
pe './install.sh'
cd ../../..
p 'It seems we lack permissons. Lets fix that in Tanzu Mission Control'
pe 'kubectl get pods -n product-api'
pe 'kubectl get pods -n spring-petclinic'
p 'Lets try our install again'
cd apps/spring-petclinic/mysql
pe './install.sh'
p 'And now we can install our app'
cd ..
pe './install.sh'
cd ../..

p 'Lets consider a more managed app experience'
cmd
cmd
pe 'cf push test-app -p apps/test-app/test-app'

p 'Lets talk microservices and service mesh'

p 'And last but not least, Tanzu Observability is receiving metrics from all of our sources'









