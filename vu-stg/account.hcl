locals {
  account_name   = "vu-stg"
  aws_account_id = "023978810987"
  state_bucket   = lower("ec2module-${local.account_name}-us-east-1-tf-state")
}