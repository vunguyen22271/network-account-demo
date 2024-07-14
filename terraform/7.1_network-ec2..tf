

# VPC: network
# Subnet: private-subnet-1
# SG: network-vpc-nonat-private-subnet-sg
# Role: "network-dev-vpc-ec2-role"

resource "aws_instance" "network-private-subnet-1-ec2" {
  # al2023-ami-2023.5.20240708.0-kernel-6.1-x86_64
  ami           = "ami-0b72821e2f351e396"
  instance_type = "t2.micro"
  subnet_id     = module.network-vpc.private_subnet_ids[0]
  private_ip    = "10.0.11.11"
  vpc_security_group_ids = [
    aws_security_group.network-vpc-nonat-private-subnet-sg.id
  ]
  key_name             = "network-ec2"
  iam_instance_profile = aws_iam_instance_profile.network-vpc-ec2-instance-profile.name

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = false # Explicitly define encryption to match AWS configuration
    tags        = local.default_tags
  }
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              amazon-linux-extras install epel -y
              service httpd start
              systemctl enable httpd.service
              echo "network-dev-vpc-private-ec2" > /var/www/html/index.html

              # Ensure the Amazon SSM Agent is enabled and started
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent
              EOF

  tags = merge({
    Name = "network-dev-vpc-private-ec2"
    },
  local.default_tags)

  lifecycle {
    ignore_changes = [
      root_block_device[0].tags,
    ]
  }
}

# VPC: network
# Subnet: nonat-private-subnet-1
# SG: network-vpc-nonat-private-subnet-sg
# Role: "network-dev-vpc-ec2-role"

resource "aws_instance" "network-nonat-private-subnet-1-ec2" {
  # al2023-ami-2023.5.20240708.0-kernel-6.1-x86_64
  ami           = "ami-0b72821e2f351e396"
  instance_type = "t2.micro"
  subnet_id     = module.network-vpc.nonat_private_subnet_ids[0]
  private_ip    = "10.0.21.11"
  vpc_security_group_ids = [
    aws_security_group.network-vpc-nonat-private-subnet-sg.id
  ]
  key_name             = "network-ec2"
  iam_instance_profile = aws_iam_instance_profile.network-vpc-ec2-instance-profile.name

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = false # Explicitly define encryption to match AWS configuration
    tags        = local.default_tags
  }
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              amazon-linux-extras install epel -y
              service httpd start
              systemctl enable httpd.service
              echo "network-dev-vpc-nonat-private-ec2" > /var/www/html/index.html

              # Ensure the Amazon SSM Agent is enabled and started
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent
              EOF

  tags = merge({
    Name = "network-dev-vpc-nonat-private-ec2"
    },
  local.default_tags)

  lifecycle {
    ignore_changes = [
      root_block_device[0].tags,
    ]
  }
}



# VPC: network
# Subnet: public-subnet-1
# SG: network-dev-vpc-public-subnet-sg
# Role: "network-dev-vpc-ec2-role"

# resource "aws_instance" "network-public-subnet-1-ec2" {
#   # al2023-ami-2023.5.20240708.0-kernel-6.1-x86_64
#   ami           = "ami-0b72821e2f351e396"
#   instance_type = "t2.micro"
#   subnet_id     = module.network-vpc.public_subnet_ids[0]
#   private_ip    = "10.0.1.11"
#   vpc_security_group_ids = [
#     aws_security_group.network-vpc-nonat-private-subnet-sg.id
#   ]
#   key_name             = "network-ec2"
#   iam_instance_profile = aws_iam_instance_profile.network-vpc-ec2-instance-profile.name

#   associate_public_ip_address = true

#   root_block_device {
#     volume_size = 8
#     volume_type = "gp3"
#     encrypted   = false # Explicitly define encryption to match AWS configuration
#     tags        = local.default_tags
#   }
#   user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               yum install -y httpd
#               amazon-linux-extras install epel -y
#               service httpd start
#               systemctl enable httpd.service
#               echo "network-dev-vpc-public-ec2" > /var/www/html/index.html

#               # Ensure the Amazon SSM Agent is enabled and started
#               systemctl enable amazon-ssm-agent
#               systemctl start amazon-ssm-agent
#               EOF

#   tags = merge({
#     Name = "network-dev-vpc-public-ec2"
#     },
#   local.default_tags)

#   lifecycle {
#     ignore_changes = [
#       root_block_device[0].tags,
#     ]
#   }
# }