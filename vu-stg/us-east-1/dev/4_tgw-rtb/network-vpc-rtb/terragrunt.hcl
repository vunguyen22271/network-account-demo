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
  source = "${get_parent_terragrunt_dir()}/_tf-modules/networking/tgw-rtb"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  tgw_rtb_name = "network-${local.env}-vpc-rtb"
  tgw_id       = dependency.tgw.outputs.tgw_id

  tgw_att_association_ids = [
    dependency.network-vpc-att.outputs.tgw_vpc_attachment_id
  ]
  
  tgw_att_propagation_ids = [
    dependency.network-vpc-att.outputs.tgw_vpc_attachment_id,
    dependency.target-vpc-att.outputs.tgw_vpc_attachment_id
  ]
  default_tags = local.default_tags
}

dependency "tgw" {
  config_path = "../../2_tgw"

  mock_outputs = {
    tgw_id = "tgw-1234567890abcdef0"
  }
}

dependency "network-vpc-att" {
  config_path = "../../3_tgw-vpc-attachment/network_vpc_att"

  mock_outputs = {
    tgw_vpc_attachment_id = "tgw-attach-1234567890abcdef0"
  }
}
dependency "target-vpc-att" {
  config_path = "../../3_tgw-vpc-attachment/target-vpc-att"

  mock_outputs = {
    tgw_vpc_attachment_id = "tgw-attach-1234567890abcdef0"
  }
}