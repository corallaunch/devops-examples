terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
  # Store state remotely (Terraform 1.10+ for use_lockfile). Create the bucket first, then uncomment.
  # backend "s3" {
  #   bucket       = "your-terraform-state-bucket"
  #   key          = "fargate-web/terraform.tfstate"
  #   region       = "ap-southeast-1"
  #   use_lockfile = true
  #   encrypt      = true
  # }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project     = var.name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

resource "aws_ecr_repository" "app" {
  name                 = var.name
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep the last 20 images"
      selection    = { tagStatus = "any", countType = "imageCountMoreThan", countNumber = 20 }
      action       = { type = "expire" }
    }]
  })
}

module "network" {
  source   = "../../modules/network"
  name     = var.name
  az_count = 3
}

module "web" {
  source             = "../../modules/ecs-fargate-service"
  name               = var.name
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
  certificate_arn    = var.certificate_arn
  image              = "${aws_ecr_repository.app.repository_url}:${var.image_tag}"
  environment        = { APP_ENV = var.environment }
}

output "alb_dns_name" {
  value = module.web.alb_dns_name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}
