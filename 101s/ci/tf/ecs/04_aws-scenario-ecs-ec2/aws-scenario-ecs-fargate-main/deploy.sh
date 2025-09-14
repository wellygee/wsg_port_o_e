#!/bin/bash

## Simulated hash per deployment, normally used by CI/CD system
HASH=$(openssl rand -hex 12)

cd infra

## Initialize Terraform
terraform init

## Generate Terraform plan file
terraform plan -var hash=${HASH} -out=infrastructure.tf.plan

## Provision resources
terraform apply -auto-approve infrastructure.tf.plan
rm -rf infrastructure.tf.plan

# ## Read ECR repository URL to push Docker image with app to registry
# REPOSITORY_URL=$(terraform output -raw ecr_repository_url)
# REPOSITORY_BASE_URL=$(sed -r 's#([^/])/[^/].*#\1#' <<< ${REPOSITORY_URL})
# aws ecr get-login-password --region eu-central-1 | \
#     docker login --username AWS --password-stdin ${REPOSITORY_BASE_URL}
