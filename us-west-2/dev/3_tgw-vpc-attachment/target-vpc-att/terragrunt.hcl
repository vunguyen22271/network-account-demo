locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  name_prefix  = local.common_vars.locals.name_prefix
  default_tags = local.common_vars.locals.default_tags
  env          = local.env_vars.locals.environment
  region       = local.region_vars.locals.aws_region
  azs          = local.region_vars.locals.azs
}

terraform {
  source = "${get_parent_terragrunt_dir()}/_tf-modules/networking/tgw-vpc-attachment"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  tgw_vpc_attachment_name = "target-${local.env}-vpc-att"
  tgw_id                  = dependency.tgw.outputs.tgw_id
  vpc_id                  = dependency.vpc.outputs.vpc_id
  subnet_ids              = dependency.vpc.outputs.nonat_private_subnet_ids
  dns_support             = "disable"
  default_tags            = local.default_tags
}

dependency "tgw" {
  config_path = "${get_parent_terragrunt_dir()}/vu-stg/us-east-1/dev/2_tgw"

  mock_outputs = {
    tgw_id = "tgw-1234567890abcdef0"
  }
}

dependency "vpc" {
  config_path = "../../1_target_vpc"

  mock_outputs = {
    vpc_id                   = "vpc-1234567890abcdef0"
    nonat_private_subnet_ids = ["subnet-12345678", "subnet-87654321", "subnet-abcdef12"]
  }
}