resource "aws_ecs_task_definition" "my-taskdf" {
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.myecr-role.arn
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "main-container"
      image     = "gomurali/exp-app-1:2"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

    }
  ])
}

resource "aws_ecs_service" "my-service" {
  name                               = "my-service"
  launch_type                        = "FARGATE"
  cluster                            = aws_ecs_cluster.my-cluster.id
  task_definition                    = aws_ecs_task_definition.my-taskdf.arn
  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  depends_on                         = [aws_iam_role_policy.myecr-role-policy, aws_lb_listener.http]
lifecycle {
    ignore_changes = [desired_count]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.TG.arn
    container_name   = "main-container"
    container_port   = 80
  }

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.allow_sgs.id]
    subnets          = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  }

}

resource "aws_ecs_cluster" "my-cluster" {
  name = "my-cluster"
  tags = {
    Name = "my-cluster"
  }
}