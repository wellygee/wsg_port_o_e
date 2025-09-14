#!/bin/bash
# Make sure all packages are up-to-date
yum update -y

echo "ECS_CLUSTER=${cluster_name}" > /etc/ecs/ecs.config