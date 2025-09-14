#!/bin/bash

## Simulated hash per deployment, normally used by CI/CD system
# HASH=$(openssl rand -hex 12)
HASH="latest"
cd Code

## Read ECR repository URL to push Docker image with app to registry
REPOSITORY_URL=$(terraform output -raw ecr_repository_url)
ACCOUNT_ID=$(sed -r 's#([^/])/[^/].*#\1#' <<< ${REPOSITORY_URL}) # 79xxxxxxxxxxx

REPOSITORY_URL="${ACCOUNT_ID}.dkr.ecr.eu-west-1.amazonaws.com/repo-server"
REPOSITORY_BASE_URL=$(sed -r 's#([^/])/[^/].*#\1#' <<< ${REPOSITORY_URL})
aws ecr get-login-password --region eu-west-1 | \
    docker login --username AWS --password-stdin ${REPOSITORY_BASE_URL}

## Build Docker image and tag new versions for every deployment
docker build --platform linux/amd64 -t repo-server ./server
docker tag repo-server:latest ${REPOSITORY_URL}:${HASH}
docker push ${REPOSITORY_URL}:${HASH}

REPOSITORY_URL="${ACCOUNT_ID}.dkr.ecr.eu-west-1.amazonaws.com/repo-client"
docker build --platform linux/amd64 -t repo-client ./client
docker tag repo-client:latest ${REPOSITORY_URL}:${HASH}
docker push ${REPOSITORY_URL}:${HASH}
