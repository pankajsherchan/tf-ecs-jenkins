resource "aws_ecr_repository" "app" {
  name                 = "${local.name_prefix}-${var.app_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${local.name_prefix}-${var.app_name}"
  }
}

moved {
  from = aws_ecr_repository.fastapi
  to   = aws_ecr_repository.app
}
