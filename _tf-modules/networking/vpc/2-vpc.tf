resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge({
    Name = var.vpc_name
    },
  var.default_tags)
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}