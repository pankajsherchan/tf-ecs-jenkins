provider "aws" {
  region = local.region
}

terraform {
  # Backend bucket is fixed; Jenkins passes the state key dynamically.
  backend "s3" {
    bucket       = "demo-ecs-terraform-state"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.56"
    }
  }
}