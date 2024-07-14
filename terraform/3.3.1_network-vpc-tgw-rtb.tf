

module "network-vpc-tgw-rtb" {
  source = "../_tf-modules/networking/tgw-rtb"

  tgw_rtb_name = "network-${local.env}-vpc-rtb"
  tgw_id       = module.tgw-us-east-1.tgw_id

  tgw_att_association_ids = [
    module.network-vpc-att.tgw_vpc_attachment_id
  ]

  tgw_att_propagation_ids = [
    module.network-vpc-att.tgw_vpc_attachment_id,
    module.target-vpc-att.tgw_vpc_attachment_id
  ]

  default_tags = local.default_tags

  depends_on = [
    module.tgw-us-east-1,
    module.network-vpc-att,
    module.target-vpc-att
  ]
}