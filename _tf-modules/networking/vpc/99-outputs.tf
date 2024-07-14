output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [
    for subnet in aws_subnet.public : subnet.id
  ]
}

output "public_subnet_rtb_ids" {
  value = [
    for rtb in aws_route_table.public : rtb.id
  ]
}

output "private_subnet_ids" {
  value = [
    for subnet in aws_subnet.private : subnet.id
  ]
}

output "private_subnet_rtb_ids" {
  value = [
    for rtb in aws_route_table.private : rtb.id
  ]
}


output "nonat_private_subnet_ids" {
  value = [
    for subnet in aws_subnet.nonat_private : subnet.id
  ]
}

output "nonat_private_subnet_rtb_ids" {
  value = [
    for rtb in aws_route_table.nonat_private_rt : rtb.id
  ]
}