terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.65.0"
    }
  }
}
# backend "s3" {
#   bucket         = var.s3_remote_backend_bucket_nm
#   key            = "dummy/dev/terraform.state"
#   region         = var.aws_region
#   dynamodb_table = var.dynamodb_remote_backend_table_nm
#   encrypt        = true
# }

provider "aws" {
  allowed_account_ids      = [var.aws_account_id]
  region                   = var.aws_region
  shared_config_files      = [var.shared_config_file]
  shared_credentials_files = [var.shared_credentials_files]
  profile                  = var.aws_config_profile
  default_tags {
    tags = {
      Terraform   = "true"
      Repository  = var.terraform_repo_name
      Environment = var.env
      Maintainer  = var.maintainer
    }
  }
}
