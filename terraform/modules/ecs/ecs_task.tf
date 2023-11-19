resource "aws_cloudwatch_log_group" "ecs" {
  name = join("-", [var.env, var.name, "ecs", "logs"])
}

data "template_file" "taskdef" {
  template = file("${path.module}/ecs_taskdef.json")

  vars = {
    container_name        = local.container_name
    image                 = aws_ecr_repository.main.repository_url
    awslogs-group         = aws_cloudwatch_log_group.ecs
    awslogs-stream-prefix = "prefix"
  }
}

resource "aws_ecs_task_definition" "main" {
  family                = join("-", [var.env, var.name, "taskdef"])
  container_definitions = data.template_file.taskdef.rendered

  cpu    = "256"
  memory = "512"

  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn       = aws_iam_role.task_exec.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  lifecycle {
    ignore_changes = [container_definitions]
  }
}
