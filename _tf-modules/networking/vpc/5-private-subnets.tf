

# Private Subnets
locals {
  num_private_subnets = length(var.private_subnets)
}

resource "aws_subnet" "private" {
  count = local.num_private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge({
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
    },
  var.default_tags)
}


# # NAT Gateway
# resource "aws_eip" "nat-eip" {
#   count = local.create_nat

#   tags = merge({
#     Name = "${var.vpc_name}-nat"
#     },
#   var.default_tags)

#   depends_on = [aws_internet_gateway.this]
# }

# resource "aws_nat_gateway" "this" {
#   count         = local.create_nat
#   allocation_id = element(aws_eip.nat-eip[*].id, count.index)
#   subnet_id     = element(aws_subnet.private[*].id, count.index)

#   tags = merge({
#     Name = "${var.vpc_name}-nat"
#     },
#   var.default_tags)
# }

# Private Route Tables
resource "aws_route_table" "private" {
  count = local.num_private_subnets

  vpc_id = aws_vpc.this.id

  tags = merge({
    Name = "${var.vpc_name}-private-route-table-${count.index + 1}"
    },
  var.default_tags)

  timeouts {
    create = "5m"
    update = "2m"
    delete = "5m"
  }
}

resource "aws_route" "private_nat_route" {
  count = local.num_private_subnets

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this[*].id, count.index)

  timeouts {
    create = "5m"
    update = "2m"
    delete = "5m"
  }
}

resource "aws_route_table_association" "private" {
  count = local.num_private_subnets

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}