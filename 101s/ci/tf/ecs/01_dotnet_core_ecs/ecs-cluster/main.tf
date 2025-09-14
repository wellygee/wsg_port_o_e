## Variables ##
variable "application" {}

variable "environment" {}
variable "role" {}
variable "vpc_id" {}

variable "instance_type" {
  description = "The instance type to use, e.g t2.small"
}

variable "subnet_ids" {
  type = list(string)
}

variable "min_size" {
  description = "Minimum instance count"
}

variable "max_size" {
  description = "Maxmimum instance count"
}

variable "desired_capacity" {
  description = "Desired instance count"
}

variable "key_name" {
  description = "SSH key name to use"
}

variable "load_balancers" {
  type    = list(string)
  default = []
}

variable "instance_ebs_optimized" {
  description = "When set to true the instance will be launched with EBS optimized turned on"
  default     = true
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  default     = 25
}

variable "docker_volume_size" {
  description = "Attached EBS volume size in GB"
  default     = 25
}

variable "associate_public_ip_address" {
  description = "Whether or not this ECS cluster will be associated with public IP addresses"
  default     = false
}

## Outputs ##
output "id" {
  value = "${aws_ecs_cluster.main.id}"
}

output "name" {
  value = "${aws_ecs_cluster.main.name}"
}

output "launch_configuration_id" {
  value = "${aws_launch_configuration.main.id}"
}

output "autoscaling_group_id" {
  value = "${aws_autoscaling_group.main.id}"
}

output "autoscaling_group_arn" {
  value = "${aws_autoscaling_group.main.arn}"
}

output "security_group_id" {
  value = "${aws_security_group.main.id}"
}
