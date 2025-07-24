variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "alb_security_group_id" {
  description = "ALB security group ID"
  type        = string
}

variable "app_image" {
  description = "Docker image for the application"
  type        = string
}

variable "app_port" {
  description = "Port on which application runs"
  type        = number
}

variable "rds_endpoint" {
  description = "RDS endpoint"
  type        = string
}

variable "rds_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
