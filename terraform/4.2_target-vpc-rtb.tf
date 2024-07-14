

# VPC: target-vpc
# Subnet: nonat-private
resource "aws_route" "target-vpc-nonat-pri-subnet-rtb-rule-1" {
  # for_each = toset(module.target-vpc.nonat_private_subnet_rtb_ids)
  # route_table_id = each.value
  count          = length(module.target-vpc.nonat_private_subnet_rtb_ids)
  route_table_id = module.target-vpc.nonat_private_subnet_rtb_ids[count.index]
  # If destination is network-vpc-cidir, route to TGW
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_id     = module.tgw-us-east-1.tgw_id

  depends_on = [
    module.target-vpc,
    module.tgw-us-east-1
  ]
}

# Subnet: private
resource "aws_route" "target-vpc-private-subnet-rtb-rule-1" {
  # for_each = toset(module.target-vpc.private_subnet_rtb_ids)
  # route_table_id = each.value
  count          = length(module.target-vpc.private_subnet_rtb_ids)
  route_table_id = module.target-vpc.private_subnet_rtb_ids[count.index]
  # If destination is network-vpc-cidir, route to TGW
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_id     = module.tgw-us-east-1.tgw_id

  depends_on = [
    module.target-vpc,
    module.tgw-us-east-1
  ]
}