#!/bin/bash
set -e

# Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

# Outputs:

# ecr_repository_url = "xxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/wg/app-ecs-serv-xxxxxxxx"
# ecs_cluster_name = "wg_ECSCluster_dev"
# ecs_service_name = "wg_ECS_Service_dev"

ECS_SERVICE_NAME=$(terraform output -state=infra/terraform.tfstate -raw ecs_service_name)
printf '%s\n' "Using ECS Service name '${ECS_SERVICE_NAME}'." >&2

ECS_CLUSTER_NAME=$(terraform output -state=infra/terraform.tfstate -raw ecs_cluster_name)
printf '%s\n' "Using ECS Cluster name '${ECS_CLUSTER_NAME}'." >&2

aws ecs update-service --cluster ${ECS_CLUSTER_NAME} --service ${ECS_SERVICE_NAME} --desired-count 0 --no-cli-pager
printf '%s\n' "'desired_count' of ECS Tasks has been set to 0." >&2

TASK_ARN=$(aws ecs describe-services --cluster ${ECS_CLUSTER_NAME} --services ${ECS_SERVICE_NAME} --no-cli-pager --query 'services[*].[taskDefinition]' --output text)
printf '%s\n' "Task ARN to be deregistered: ${TASK_ARN}" >&2

aws ecs deregister-task-definition --task-definition ${TASK_ARN} --no-cli-pager
printf '%s\n' "Task deregistered. Checking ECS Service status to not be 'DRAINING'..." >&2

SERVICE_STATUS=$(aws ecs describe-services --cluster ${ECS_CLUSTER_NAME} --services ${ECS_SERVICE_NAME} --query 'services[*].[status]' --output text)
if [[ $SERVICE_STATUS == "DRAINING" ]]; then
  printf '%s\n' "ECS Service is in status 'DRAINING'. Deployment might fail. Check README for more information before re-running this command." >&2
  exit 1
else
  printf '%s\n' "ECS Service is in status '${SERVICE_STATUS}', deleting now to avoid draining issues..." >&2
  aws ecs delete-service --cluster ${ECS_CLUSTER_NAME} --service ${ECS_SERVICE_NAME} --no-cli-pager
  printf '%s\n' "ECS Service successfully deleted." >&2
fi

printf '%s\n' "Running 'terraform destroy' now." >&2
cd infra && terraform destroy -var hash=null -auto-approve
