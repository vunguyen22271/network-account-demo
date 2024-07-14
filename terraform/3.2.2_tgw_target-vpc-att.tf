
module "target-vpc-att" {
  source = "../_tf-modules/networking/tgw-vpc-attachment"

  tgw_vpc_attachment_name = "target-${local.env}-vpc-att"
  tgw_id                  = module.tgw-us-east-1.tgw_id
  vpc_id                  = module.target-vpc.vpc_id
  subnet_ids              = module.target-vpc.nonat_private_subnet_ids
  dns_support             = "disable"
  default_tags            = local.default_tags

  depends_on = [
    module.target-vpc,
    module.tgw-us-east-1
  ]
}