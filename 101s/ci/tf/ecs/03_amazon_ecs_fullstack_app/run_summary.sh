# NOTE - this is just a summary

cd /c/TnF/temp_tests/ecs/03_amazon_ecs_fullstack_app_v_good

# ECR
cd Infrastructure/01_ecr/

terraform init

terraform plan -out=tfplan
terraform apply -auto-approve tfplan
echo "ECR deployment completed successfully."
# Build and push Docker images
cd ../..
./deploy_container.sh
echo "Docker images pushed successfully."

# ECS Cluster

# All other infra
cd Infrastructure/02_all/

terraform init

terraform plan -out=tfplan

terraform apply -auto-approve tfplan

echo "Deployment completed successfully."

terraform destroy -auto-approve

echo "Infrastructure destroyed successfully."


cd ../
cd 01_ecr/
terraform destroy -auto-approve
echo "ECR destroyed successfully."
#--------------

