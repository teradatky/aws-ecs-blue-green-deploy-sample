resource "aws_lb_target_group" "blue" {
  name        = join("-", [var.env, var.name, "tg", "blue"])
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 60
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = 200
  }
}

resource "aws_lb_target_group" "green" {
  name        = join("-", [var.env, var.name, "tg", "green"])
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 60
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = 200
  }
}
