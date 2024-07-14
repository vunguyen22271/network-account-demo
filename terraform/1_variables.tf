locals {
  name_prefix = "network"
  region      = "us-east-1"
  azs         = ["us-east-1a", "us-east-1b", "us-east-1c"]
  env         = "dev"

  default_tags = {
    "env"     = "dev"
    "project" = "network"
  }
}
