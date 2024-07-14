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
  source = "../../../../_tf-modules/networking/tgw"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  tgw_name                        = "network-${local.env}-tgw"
  description                     = "Network TGW"
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  dns_support                     = "disable"
  default_tags                    = local.default_tags
}