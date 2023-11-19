resource "aws_ecs_service" "main" {
  name            = join("-", [var.env, var.name, "service"])
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [aw_security_group.ecs.id]
  }

  load_balancer {
    container_name   = local.container_name
    container_port   = 80
    target_group_arn = aws_lb_target_group.blue.arn
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  lifecycle {
    ignore_changes = [load_balancer, task_definition]
  }

  depends_on = [terraform_data.initial_build]

}
