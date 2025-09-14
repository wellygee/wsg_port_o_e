# ------- Random numbers intended to be used as unique identifiers for resources -------
resource "random_id" "RANDOM_ID" {
  byte_length = "2"
}

# ------- Account ID -------
data "aws_caller_identity" "id_current_account" {}

# ------- Creating server ECR Repository to store Docker Images -------
module "ecr_server" {
  source = "../Modules/ECR"
  name   = "repo-server"
}

# ------- Creating client ECR Repository to store Docker Images -------
module "ecr_client" {
  source = "../Modules/ECR"
  name   = "repo-client"
}
