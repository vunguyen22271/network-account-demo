resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = var.subnet_ids
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id
  dns_support        = var.dns_support

  tags = merge(
    var.default_tags,
    {
      Name = var.tgw_vpc_attachment_name
    }
  )
}
