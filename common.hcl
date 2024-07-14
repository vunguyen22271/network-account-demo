locals {
  name_prefix    = "network"
  default_region = "us-east-1"
  default_tags = {
    "environment"= "dev"
    "project"    = "network"
  }
}