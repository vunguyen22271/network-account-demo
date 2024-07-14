

module "tgw-us-east-1" {
  source = "../_tf-modules/networking/tgw"

  tgw_name                        = "network-${local.env}-tgw"
  description                     = "Network TGW"
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  dns_support                     = "disable"
  default_tags                    = local.default_tags
}