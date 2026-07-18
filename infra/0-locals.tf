locals {
  region      = "us-east-1"
  zone1       = "us-east-1a"
  zone2       = "us-east-1b"
  name_prefix = "${var.project_name}-${var.environment}"
  app_image   = "${aws_ecr_repository.app.repository_url}:${var.app_image_tag}"
}
