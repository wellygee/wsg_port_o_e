# .NET Core ECS demo

Deployment requirements:
* Terraform (https://terraform.io)
* Docker (https://www.docker.com/)

Deploy the ECR repository:
```
cd terraform/ecr-repo
terraform plan
terraform apply
```

Build the Docker container:
```
docker build --rm -f Dockerfile -t dotnet-ecs-demo:latest .
```

Login to ECR and push the Docker image:
```
aws ecr get-login
docker tag dotnet-ecs-demo <AWS ACCOUNT ID>.dkr.ecr.us-east-1.amazonaws.com/dotnet-ecs-demo:latest
docker push <AWS ACCOUNT ID>.dkr.ecr.us-east-1.amazonaws.com/dotnet-ecs-demo
```

Deploy the ECS cluster and the demo container:
```
cd terraform
terraform plan
terraform apply

#------ A
# terraform plan -var-file="variables.tfvars"
#------

#------ B
# If you want Terraform to always use a specific .tfvars file, you can name it 
# terraform.tfvars—Terraform will load # it automatically without extra flags.
#------

#------ C
# To auto-apply variables with Terraform using an auto.tfvars file, simply create 
# a file ending with .auto.tfvars (for example, variables.auto.tfvars) in your 
# Terraform directory. Terraform will automatically load any .auto.tfvars files 
# without needing extra flags.
#------
```
