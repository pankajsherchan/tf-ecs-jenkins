resource "aws_ecr_repository" "fastapi" {
  name                 = "${local.ecs_name}-fastapi"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${local.ecs_name}-fastapi"
  }
}
