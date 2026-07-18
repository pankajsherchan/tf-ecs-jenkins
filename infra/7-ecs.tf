resource "aws_ecs_cluster" "main" {
  name = "${local.name_prefix}-ecs-cluster"
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${local.name_prefix}/${var.app_name}"
  retention_in_days = 7

  tags = {
    Name = "${local.name_prefix}-${var.app_name}-logs"
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "${local.name_prefix}-ecs-task-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.name_prefix}-ecs-task-execution"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_ecs_task_definition" "app" {
  family                   = "${local.name_prefix}-${var.app_name}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = var.app_name
      image     = local.app_image
      essential = true

      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = local.region
          awslogs-stream-prefix = var.app_name
        }
      }
    }

  ])

  tags = {
    Name = "${local.name_prefix}-${var.app_name}-task"
  }

}

resource "aws_security_group" "ecs_tasks_sg" {
  name        = "${local.name_prefix}-ecs-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = aws_vpc.main.id

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Allow HTTP from ALB"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  tags = {
    Name = "${local.name_prefix}-ecs-tasks-sg"
  }
}

resource "aws_ecs_service" "app" {
  name            = "${local.name_prefix}-${var.app_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  # The ECR repository is empty during the first infrastructure apply. Keep
  # the service at zero tasks until the app pipeline pushes the first image.
  desired_count = 0
  launch_type   = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.private_us_east_1a.id, aws_subnet.private_us_east_1b.id]
    security_groups  = [aws_security_group.ecs_tasks_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = var.app_name
    container_port   = var.app_port
  }

  lifecycle {
    # The app pipeline owns deployments and scales the service to one task
    # after it has pushed the real application image that ECS can pull.
    ignore_changes = [task_definition, desired_count]
  }
}

resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-alb-sg"
  description = "Security group for the application load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name_prefix}-alb-sg"
  }
}

resource "aws_lb" "main" {
  name               = "${local.name_prefix}-alb"
  load_balancer_type = "application"
  internal           = false


  subnets = [
    aws_subnet.public_us_east_1a.id,
    aws_subnet.public_us_east_1b.id
  ]

  security_groups = [aws_security_group.alb.id]

  tags = {
    Name = "${local.name_prefix}-alb"
  }
}


resource "aws_lb_target_group" "app" {
  name        = "${local.name_prefix}-${var.app_name}-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = var.app_health_check_path
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${local.name_prefix}-${var.app_name}-tg"
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
