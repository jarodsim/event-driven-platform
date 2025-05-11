output "role_name" {
  value       = aws_iam_role.this.name
  description = "Nome da IAM Role"
}

output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "ARN da IAM Role"
}
