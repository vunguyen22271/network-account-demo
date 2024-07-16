

resource "aws_route53_zone" "dynamodb-vpc-endpoint-phz" {
  name = "dynamodb.us-east-1.vpce.amazonaws.com"

  vpc {
    vpc_id = module.target-vpc.vpc_id
  }

  vpc {
    vpc_id = module.network-vpc.vpc_id
  }
}

resource "aws_route53_record" "server1-record" {
  zone_id = aws_route53_zone.dynamodb-vpc-endpoint-phz.zone_id
  name    = "dynamodb.us-east-1.vpce.amazonaws.com"
  type    = "A"

  alias {
    name                   = aws_vpc_endpoint.target-vpc-dynamodb-endpoint.dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.target-vpc-dynamodb-endpoint.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }
}
