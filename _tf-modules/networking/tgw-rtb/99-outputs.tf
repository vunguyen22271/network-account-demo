
output "tgw_rtb_id" {
  value       = aws_ec2_transit_gateway_route_table.this.id
  description = "The ID of the Transit Gateway VPC Route Table."
}

output "tgw_rtb_association_ids" {
  value       = aws_ec2_transit_gateway_route_table_association.this[*].id
  description = "The IDs of the Transit Gateway VPC Route Table Associations."
}

output "tgw_rtb_propagation_ids" {
  value       = aws_ec2_transit_gateway_route_table_propagation.this[*].id
  description = "The IDs of the Transit Gateway VPC Route Table Propagations."
}