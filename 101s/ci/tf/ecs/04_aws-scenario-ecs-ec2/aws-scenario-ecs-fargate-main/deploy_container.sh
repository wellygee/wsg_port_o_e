#!/bin/bash

## Simulated hash per deployment, normally used by CI/CD system
# HASH=$(openssl rand -hex 12)
HASH="harsh"
cd infra

## Read ECR repository URL to push Docker image with app to registry
REPOSITORY_URL=$(terraform output -raw ecr_repository_url)
REPOSITORY_URL="xxxxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/wg/app-ecs-serv-xxxxxxxx"
REPOSITORY_BASE_URL=$(sed -r 's#([^/])/[^/].*#\1#' <<< ${REPOSITORY_URL})
aws ecr get-login-password --region eu-west-1 | \
    docker login --username AWS --password-stdin ${REPOSITORY_BASE_URL}

## Build Docker image and tag new versions for every deployment
# docker build --platform linux/amd64 -t wg/$1 ../app
docker build --platform linux/amd64 -t wg ../app
docker tag wg:latest ${REPOSITORY_URL}:latest
# docker tag wg:latest ${REPOSITORY_URL}:${HASH}
docker push ${REPOSITORY_URL}:latest
# docker push ${REPOSITORY_URL}:${HASH}
