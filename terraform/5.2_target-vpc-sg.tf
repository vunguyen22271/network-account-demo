

resource "aws_security_group" "target-vpc-nonat-private-subnet-sg" {
  name        = "target-${local.env}-vpc-nonat-private-subnet-sg"
  description = "target-${local.env}-vpc-nonat-private-subnet-sg"
  vpc_id      = module.target-vpc.vpc_id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["10.1.0.0/16"]
    description = "Allow all traffic within VPC."
  }

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow target VPC EC2 to communicate with network VPC EC2 via tgw."
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow connect to internet."
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow connect to internet over IPv6."
  }

  tags = local.default_tags

  depends_on = [
    module.target-vpc
  ]
}