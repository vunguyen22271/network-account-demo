

# VPC: target-vpc
# Role for EC2

resource "aws_iam_policy" "target-vpc-ec2-policy" {
  name        = "target-${local.env}-vpc-ec2-policy"
  path        = "/"
  description = "target-${local.env}-vpc-ec2-policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DescribeEC2Instances",
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AccessDynamoDBTables",
      "Effect": "Allow",
      "Action": [
        "dynamodb:*"
      ],
      "Resource": [
        "arn:aws:dynamodb:us-east-1:023978810987:table/targetdb",
        "arn:aws:dynamodb:us-east-1:023978810987:table/network-vu-stg-us-east-1-tf-locks"
      ]
    }
  ]
}
EOF

  # tags = local.default_tags
}

resource "aws_iam_role" "target-vpc-ec2-role" {
  name               = "target-${local.env}-vpc-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  # tags = local.default_tags
}

resource "aws_iam_policy_attachment" "target-vpc-ec2-policy-att-1" {
  name       = "target-${local.env}-vpc-ec2-policy-att-1"
  roles      = [aws_iam_role.target-vpc-ec2-role.name]
  policy_arn = aws_iam_policy.target-vpc-ec2-policy.arn
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore-2" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# resource "aws_iam_policy_attachment" "target-vpc-ec2-policy-att-2" {
#   name       = "target-${local.env}-vpc-ec2-policy-att-2"
#   roles      = ["${aws_iam_role.target-vpc-ec2-role.name}"]
#   # policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore-2.arn
# }

resource "aws_iam_role_policy_attachment" "target-vpc-ec2-policy-att-2" {
  # name       = "target-${local.env}-vpc-ec2-policy-att-2"
  role = aws_iam_role.target-vpc-ec2-role.name
  # policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore-2.arn
}

resource "aws_iam_instance_profile" "target-vpc-ec2-instance-profile" {
  name = aws_iam_role.target-vpc-ec2-role.name
  role = aws_iam_role.target-vpc-ec2-role.name

  # tags = local.default_tags
}