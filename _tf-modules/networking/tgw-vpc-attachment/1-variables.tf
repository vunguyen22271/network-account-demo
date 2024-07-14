
variable "tgw_vpc_attachment_name" {
  description = "(Optional) Name of the EC2 Transit Gateway VPC Attachment."
  type        = string
}

variable "tgw_id" {
  description = "(Required) Identifier of EC2 Transit Gateway."
  type        = string
}

variable "vpc_id" {
  description = "(Required) Identifier of EC2 VPC."
  type        = string
}

variable "subnet_ids" {
  description = "(Required) Identifiers of EC2 Subnets."
  type        = list(string)
}

variable "dns_support" {
  description = "(Optional) Whether DNS support is enabled. Valid values: disable, enable. Default value: enable."
  type        = string
  default     = "disable"
}

variable "default_tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(string)
  default     = {}
}