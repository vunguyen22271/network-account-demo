
variable "tgw_rtb_name" {
  description = "(Required) Name of the EC2 Transit Gateway VPC Route Table."
  type        = string
}

variable "tgw_att_association_ids" {
  description = "(Required) Identifier of EC2 Transit Gateway Attachment."
  type        = list(string)
}

variable "tgw_att_propagation_ids" {
  description = "(Required) Identifier of EC2 Transit Gateway Attachment."
  type        = list(string)
}

variable "tgw_id" {
  description = "(Required) Identifier of EC2 Transit Gateway."
  type        = string
}

variable "default_tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(string)
  default     = {}
}