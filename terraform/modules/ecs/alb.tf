resource "aws_lb" "main" {
  name               = join("-", [var.env, var.name, "alb"])
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.subnet_ids

  tags = {
    Name = join("-", [var.env, var.name, "cluster"])
  }
}
