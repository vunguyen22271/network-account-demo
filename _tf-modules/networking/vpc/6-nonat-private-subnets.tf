

# Nonat Private Subnets
locals {
  num_nonat_private_subnets = length(var.nonat_private_subnets)
}

resource "aws_subnet" "nonat_private" {
  count = local.num_nonat_private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.nonat_private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge({
    Name = "${var.vpc_name}-nonat-private-subnet-${count.index + 1}"
    },
  var.default_tags)
}

# Nonat Private Route Tables
resource "aws_route_table" "nonat_private_rt" {
  count = local.num_nonat_private_subnets

  vpc_id = aws_vpc.this.id

  tags = merge({
    Name = "${var.vpc_name}-nonat-private-rtb-${count.index + 1}"
    },
  var.default_tags)

  timeouts {
    create = "5m"
    update = "2m"
    delete = "5m"
  }
}

resource "aws_route_table_association" "nonat_private" {
  count = local.num_nonat_private_subnets

  subnet_id      = aws_subnet.nonat_private[count.index].id
  route_table_id = aws_route_table.nonat_private_rt[count.index].id
}