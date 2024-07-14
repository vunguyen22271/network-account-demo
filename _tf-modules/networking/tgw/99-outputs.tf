

output "tgw_arn" {
  value       = aws_ec2_transit_gateway.this.arn
  description = "EC2 Transit Gateway Amazon Resource Name (ARN)"
}

output "tgw_id" {
  value       = aws_ec2_transit_gateway.this.id
  description = "EC2 Transit Gateway identifier"
}
