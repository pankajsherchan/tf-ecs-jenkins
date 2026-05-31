locals {
  env       = "dev"
  region    = "us-east-1"
  zone1     = "us-east-1a"
  zone2     = "us-east-1b"
  ecs_name  = "demo"
  api_image = var.api_name == "fastapi" ? "${aws_ecr_repository.fastapi.repository_url}:${var.api_image_tag}" : "nginx:${var.api_image_tag}"
}
