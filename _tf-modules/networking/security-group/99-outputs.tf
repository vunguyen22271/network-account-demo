output "sg_id" {
  description = "Security Group ID"
  value       = aws_security_group.sg.id
}

output "sg_arn" {
  description = "Security Group ARN"
  value       = aws_security_group.sg.arn
}