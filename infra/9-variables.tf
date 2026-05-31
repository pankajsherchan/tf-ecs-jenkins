variable "api_name" {
  description = "Name of the app running in ECS"
  type        = string
  default     = "nginx"
}

variable "api_port" {
  description = "Container port exposed by the app"
  type        = number
  default     = 80
}

variable "api_health_check_path" {
  description = "Health check path for the target group"
  type        = string
  default     = "/"
}

variable "api_image_tag" {
  description = "Container image tag to deploy"
  type        = string
  default     = "latest"
}
