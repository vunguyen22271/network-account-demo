resource "aws_ec2_transit_gateway" "this" {
  description                     = var.description
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                     = var.dns_support

  tags = merge({
    Name = var.tgw_name
    },
  var.default_tags)
}