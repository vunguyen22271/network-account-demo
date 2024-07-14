
module "network-vpc" {
  source = "../_tf-modules/networking/vpc"

  vpc_name              = "network-${local.env}-vpc"
  region                = local.region
  azs                   = local.azs
  cidr_block            = "10.0.0.0/16"
  public_subnets        = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets       = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  nonat_private_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
  create_igw            = true
  create_nat            = true
  enable_dns_support    = true
  enable_dns_hostnames  = true
  default_tags          = local.default_tags
}

