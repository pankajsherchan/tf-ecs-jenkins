variable "project_name" {
  description = "Project name used in AWS resource names"
  type        = string
  default     = "demo"
}

variable "environment" {
  description = "Deployment environment used in AWS resource names"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Name of the app running in ECS"
  type        = string
  default     = "api"
}

variable "app_port" {
  description = "Container port exposed by the app"
  type        = number
  default     = 8000
}

variable "app_health_check_path" {
  description = "Health check path for the target group"
  type        = string
  default     = "/health"
}

variable "app_image_tag" {
  description = "Container image tag to deploy"
  type        = string
  default     = "latest"
}
