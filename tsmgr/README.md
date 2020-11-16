Use nginx ingress. annotation is already in values.yml so it's probably been tested.

### Install instructions
1. Download KSM archive from TanzuNet
1. Unpack the KSM archive into the `ksm` folder
1. Update the values in `ksm/values-lab.yaml.template`
    * `imageCredentialsForKSMImages.*`
    * `broker.repository` and `broker.password`
    * `daemon.repository` and `daemon.password`
    * `chartmuseum.env.open.BASIC_AUTH_PASS`
    * See [Ingress](#Ingress) section below
    * `postgresql.postgresqlPassword` and `postgresql.encryptionKey`
1. `ingress/secret.sh` to create TLS secret for Ingress resources
1. `install.sh`
1. `kubectl apply -f service-account.yml`
1. `create-creds.sh`
1. `ksm cluster register cluster1 cluster-creds.yaml`
1. `ksm offer save ksm mysql-1.x.tgx`
1. cf create-service-broker ksm-1 admin password http://broker.ksm.lab.home:32687
1. `cf service-brokers`
1. `cf service-access`
1. `cf enable-service-access mysql`


### Ingress
```
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
  hosts:
    - ksm.lab.home
    - broker.ksm.lab.home 
    - daemon.ksm.lab.home
  tls:
    - secretName: broker-tls
      hosts:
        - ksm.lab.home
        - broker.ksm.lab.home
        - daemon.ksm.lab.home
```

OR

```
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
  hosts:
    - ksm.lab.home
    - broker.ksm.lab.home 
    - daemon.ksm.lab.home
```


### CF
```
cf:
  brokerUrl: broker.ksm.lab.home
  brokerName: my-broker
  apiAddress: api.sys.tas.lab.home
  username: admin
  password: password
  skipSslValidation: false
```
