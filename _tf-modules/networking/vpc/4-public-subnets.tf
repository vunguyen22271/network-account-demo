locals {
  create_nat = var.create_nat == true ? 1 : 0
}

# IGW
resource "aws_internet_gateway" "this" {
  count  = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = merge({
    Name = "${var.vpc_name}-igw"
    },
  var.default_tags)
}

# Public Subnets
locals {
  num_public_subnets = length(var.public_subnets)
}

resource "aws_subnet" "public" {
  count = local.num_public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge({
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
    },
  var.default_tags)
}

# Public Route Tables
resource "aws_route_table" "public" {
  count = local.num_public_subnets

  vpc_id = aws_vpc.this.id

  tags = merge({
    Name = "${var.vpc_name}-public-route-table-${count.index + 1}"
    },
  var.default_tags)

  timeouts {
    create = "5m"
    update = "2m"
    delete = "5m"
  }
}

resource "aws_route" "public_internet_route" {
  count = local.num_public_subnets

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
    update = "2m"
    delete = "5m"
  }
}

resource "aws_route_table_association" "public" {
  count = local.num_public_subnets

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

# NAT Gateway
resource "aws_eip" "nat-eip" {
  count = local.create_nat

  tags = merge({
    Name = "${var.vpc_name}-nat"
    },
  var.default_tags)

  depends_on = [
    aws_internet_gateway.this,
    aws_subnet.public
  ]
}

resource "aws_nat_gateway" "this" {
  count         = local.create_nat
  allocation_id = element(aws_eip.nat-eip[*].id, count.index)
  subnet_id     = element(aws_subnet.public[*].id, count.index)

  tags = merge({
    Name = "${var.vpc_name}-nat"
    },
  var.default_tags)
}