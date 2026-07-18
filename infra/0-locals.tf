locals {
  env                    = "dev"
  region                 = "us-east-1"
  zone1                  = "us-east-1a"
  zone2                  = "us-east-1b"
  ecs_name               = "demo-ecs"
  api_image              = "${aws_ecr_repository.fastapi.repository_url}:${var.api_image_tag}"
  terraform_state_bucket = "demo-ecs-terraform-state"
}
