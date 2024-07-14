

module "target-vpc" {
  source = "../_tf-modules/networking/vpc"

  vpc_name              = "target-${local.env}-vpc"
  region                = local.region
  azs                   = local.azs
  cidr_block            = "10.1.0.0/16"
  public_subnets        = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  private_subnets       = ["10.1.11.0/24", "10.1.12.0/24", "10.1.13.0/24"]
  nonat_private_subnets = ["10.1.21.0/24", "10.1.22.0/24", "10.1.23.0/24"]
  create_igw            = true
  create_nat            = true
  enable_dns_support    = true
  enable_dns_hostnames  = true
  default_tags          = local.default_tags
}