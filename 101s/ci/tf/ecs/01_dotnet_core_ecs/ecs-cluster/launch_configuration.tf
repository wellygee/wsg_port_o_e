# data "aws_ami" "ecs_ami" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["amzn-ami-2016.09.g-amazon-ecs-optimized"]
#   }
# }

# data "aws_ami" "amazon_linux" {
data "aws_ami" "ecs_ami" {  
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-ecs-hvm-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "environment" {
  template = "${file("${path.module}/scripts/environment.sh")}"

  vars = {
    application = "${var.application}"
    environment = "${var.environment}"
    role        = "${var.role}"
  }
}

data "template_file" "efs_mount" {
  template = "${file("${path.module}/scripts/efs_mount.sh")}"

  vars = {
    filesystem_id = "${aws_efs_file_system.efs.id}"
  }
}

data "template_file" "ecs_join" {
  template = "${file("${path.module}/scripts/ecs_join.sh")}"

  vars = {
    cluster_name = "${aws_ecs_cluster.main.name}"
  }
}


data "template_cloudinit_config" "user_data" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.environment.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${file("${path.module}/scripts/awslogs/ecs_logs.sh")}"
  }

  part {
    content_type = "text/upstart-job"
    filename = "awslogs-reconfig"
    content      = "${file("${path.module}/scripts/awslogs/awslogs.upstart")}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.efs_mount.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.ecs_join.rendered}"
  }
}

resource "aws_launch_configuration" "main" {
  name_prefix = "${var.application}-${var.environment}-${var.role}-"

  image_id                    = "${data.aws_ami.ecs_ami.id}"
  instance_type               = "${var.instance_type}"
  ebs_optimized               = "${var.instance_ebs_optimized}"
  iam_instance_profile        = "${aws_iam_instance_profile.profile.id}"
  user_data                   = "${data.template_cloudinit_config.user_data.rendered}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.main.id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  enable_monitoring           = false

  # root
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.root_volume_size}"
  }

  # docker
  ebs_block_device {
    device_name = "/dev/xvdcz"
    volume_type = "gp2"
    volume_size = "${var.docker_volume_size}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
