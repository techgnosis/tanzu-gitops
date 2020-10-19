#! /usr/bin/env bash

set -euo pipefail

vault login


# Create a SA for Vault. This SA is used by the Kubernetes auth functionality of Vault
kubectl -n vault create serviceaccount vault-auth

# Bind a role to the vault-auth SA
kubectl -n vault apply --filename vault-auth-service-account.yml


# In this phase we collect some information from the vault-auth SA for use later
# when configuring Kubernetes Vault auth

# Set VAULT_SA_NAME to the service account you created earlier
export VAULT_SA_NAME=$(kubectl -n vault get sa vault-auth -o jsonpath="{.secrets[*]['name']}")

# Set SA_JWT_TOKEN value to the service account JWT used to access the TokenReview API
export SA_JWT_TOKEN=$(kubectl -n vault get secret $VAULT_SA_NAME -o jsonpath="{.data.token}" | base64 --decode; echo)

# Set SA_CA_CRT to the PEM encoded CA cert used to talk to Kubernetes API
export SA_CA_CRT=$(kubectl -n vault get secret $VAULT_SA_NAME -o jsonpath="{.data['ca\.crt']}" | base64 --decode; echo)

# Look in your cloud provider console for this value
export K8S_HOST=cluster1.lab.home

# Write a policy called 'kes' for use later
vault policy write kes kes-vault-policy.hcl

# Enable kubernetes auth
vault auth enable kubernetes

vault write auth/kubernetes/config \
token_reviewer_jwt="$SA_JWT_TOKEN" \
kubernetes_host="https://$K8S_HOST" \
kubernetes_ca_cert="$SA_CA_CRT"

vault write auth/kubernetes/role/kes \
bound_service_account_names=kes-kubernetes-external-secrets \
bound_service_account_namespaces=kes \
policies=kes \
ttl=1440h
