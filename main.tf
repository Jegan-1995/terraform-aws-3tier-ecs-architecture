
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  azs          = data.aws_availability_zones.available.names
  
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  
  tags = var.tags
}

# Application Load Balancer Module
module "alb" {
  source = "./modules/alb"
  
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  
  tags = var.tags
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"
  
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  alb_target_group_arn = module.alb.target_group_arn
  alb_security_group_id = module.alb.security_group_id
  
  app_image = var.app_image
  app_port  = var.app_port
  
  rds_endpoint = module.rds.endpoint
  rds_password = var.rds_password
  
  tags = var.tags
}

# RDS Module
module "rds" {
  source = "./modules/rds"
  
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  ecs_security_group_id = module.ecs.security_group_id
  
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.rds_password
  
  tags = var.tags
}
