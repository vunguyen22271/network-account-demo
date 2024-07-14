
variable "tgw_name" {
  description = "Name of the Transit Gateway"
  type        = string
  default     = "Network-us-east-1-TGW"
}

variable "auto_accept_shared_attachments" {
  description = "(Optional) Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable"
  type        = string
  default     = "disable"
}

variable "default_route_table_association" {
  description = "(Optional) Whether resource attachments are automatically associated with the default association route table. Valid values: disable, enable. Default value: enable."
  type        = string
  default     = "disable"
}

variable "default_route_table_propagation" {
  description = "(Optional) Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: disable, enable. Default value: enable."
  type        = string
  default     = "disable"
}

variable "dns_support" {
  description = "(Optional) Whether DNS support is enabled. Valid values: disable, enable. Default value: enable."
  type        = string
  default     = "disable"
}

variable "description" {
  description = "(Optional) Description of the EC2 Transit Gateway."
  type        = string
  default     = "Network-TGW"
}

variable "default_tags" {
  description = "Default tags for the VPC"
  type        = map(string)
  default     = {}
}
