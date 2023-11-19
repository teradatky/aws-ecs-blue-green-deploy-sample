resource "aws_ecs_cluster" "main" {
  name = join("-", [var.env, var.name, "cluster"])
}
