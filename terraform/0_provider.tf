terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

  backend "s3" {
    profile        = "vu-stg"
    encrypt        = true
    bucket         = "network-vu-stg-us-east-1-tf-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "network-vu-stg-us-east-1-tf-locks"
  }
}

provider "aws" {
  profile = "vu-stg"
  region  = "us-east-1"

  default_tags {
    tags = {
      "environment" = "dev"
      "project"     = "network"
    }
  }
}
