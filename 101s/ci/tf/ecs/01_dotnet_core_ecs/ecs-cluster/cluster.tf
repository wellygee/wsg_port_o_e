resource "aws_ecs_cluster" "main" {
  name = "${var.application}-${var.environment}-${var.role}"

  lifecycle {
    create_before_destroy = true
  }
}
