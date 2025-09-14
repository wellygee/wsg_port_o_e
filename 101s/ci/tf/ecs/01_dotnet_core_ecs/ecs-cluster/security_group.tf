resource "aws_security_group" "main" {
  name        = "${var.application}-${var.environment}-${var.role}-ecs"
  vpc_id      = "${var.vpc_id}"
  description = "Allows traffic from and to the EC2 instances of the ECS cluster"
}

resource "aws_security_group_rule" "cluster_egress" {
  security_group_id = "${aws_security_group.main.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "efs" {
  name        = "${var.application}-${var.environment}-${var.role}-efs"
  vpc_id      = "${var.vpc_id}"
  description = "Allows traffic to EFS"
}

resource "aws_security_group_rule" "efs_ingress" {
  security_group_id        = "${aws_security_group.efs.id}"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.main.id}"
}
