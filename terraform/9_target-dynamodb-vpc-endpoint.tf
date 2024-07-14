

resource "aws_vpc_endpoint" "target-vpc-dynamodb-endpoint" {
  vpc_id       = module.target-vpc.vpc_id
  service_name = "com.amazonaws.us-east-1.dynamodb"

  # Gateway endpoints are used for services that are powered by AWS PrivateLink
  # vpc_endpoint_type = "Gateway"
  # route_table_ids  = module.target-vpc.nonat_private_subnet_rtb_ids

  # Interface endpoints are used for services that are powered by AWS PrivateLink
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = false
  security_group_ids  = [aws_security_group.target-vpc-nonat-private-subnet-sg.id]
  subnet_ids          = module.target-vpc.nonat_private_subnet_ids

  tags = merge(
    {
      Name = "target-vpc-dynamodb-endpoint"
    },
    local.default_tags
  )
}