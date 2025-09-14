resource "aws_efs_file_system" "efs" {
  creation_token = "${var.application}-${var.environment}-${var.role}"

  tags = {
    Name = "${var.application}-${var.environment}-${var.role}"
  }
}

resource "aws_efs_mount_target" "targets" {
  count           = "${length(var.subnet_ids)}"
  file_system_id  = "${aws_efs_file_system.efs.id}"
  subnet_id       = "${var.subnet_ids[count.index]}"
  security_groups = ["${aws_security_group.efs.id}"]
}
