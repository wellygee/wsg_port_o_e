variable "region" {
  default = "eu-west-1"
}

variable "profile" {
  default = "default"
}

variable "environment_name" {
}

# VPC
variable "vpc_id" {
  type    = string
}

variable "vpc_subnet_id" {
  type    = string
}

variable "vpc_subnet_ids" {
  type    = list(string)
}

variable "acct_id" {
  type    = string
}
