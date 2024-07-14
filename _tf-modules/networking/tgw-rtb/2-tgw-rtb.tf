

resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = var.tgw_id

  tags = merge(
    var.default_tags,
    {
      Name = var.tgw_rtb_name
    }
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count                          = length(var.tgw_att_association_ids)
  transit_gateway_attachment_id  = var.tgw_att_association_ids[count.index]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  count                          = length(var.tgw_att_propagation_ids)
  transit_gateway_attachment_id  = var.tgw_att_propagation_ids[count.index]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}