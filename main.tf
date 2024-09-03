terraform {
  required_providers {
      aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
      }
  }
  backend "s3" {
    bucket         = "min-tfstate"
    key            = "terraform/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "min-tfstate-lock" # (optional) state locking을 위해 사용
  }
}

# resource "aws_s3_bucket" "min-tfstate" {
#   bucket = "min-tfstate"
# }

# resource "aws_s3_bucket_versioning" "min-tfstate-versioning" {
#   bucket = aws_s3_bucket.min-tfstate.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_dynamodb_table" "terraform_state_lock" {
#   name           = "min-tfstate-lock"
#   hash_key       = "LockID"
#   billing_mode   = "PAY_PER_REQUEST"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_vpc" "this" {
  cidr_block = "10.99.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "test-vpc"
  }
}