

# VPC: network-vpc
# Subnet: nonat-private
resource "aws_route" "network-vpc-nonat-pri-subnet-rtb-rule-1" {
  # for_each = toset(module.network-vpc.nonat_private_subnet_rtb_ids)
  # route_table_id = each.value
  count          = length(module.network-vpc.nonat_private_subnet_rtb_ids)
  route_table_id = module.network-vpc.nonat_private_subnet_rtb_ids[count.index]
  # If destination is target-vpc-cidir, route to TGW
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id     = module.tgw-us-east-1.tgw_id

  depends_on = [
    module.network-vpc,
    module.tgw-us-east-1
  ]
}

# Subnet: private
resource "aws_route" "network-vpc-private-subnet-rtb-rule-1" {
  # for_each = toset(module.network-vpc.private_subnet_rtb_ids)
  # route_table_id = each.value
  count          = length(module.network-vpc.private_subnet_rtb_ids)
  route_table_id = module.network-vpc.private_subnet_rtb_ids[count.index]
  # If destination is target-vpc-cidir, route to TGW
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id     = module.tgw-us-east-1.tgw_id

  depends_on = [
    module.network-vpc,
    module.tgw-us-east-1
  ]
}