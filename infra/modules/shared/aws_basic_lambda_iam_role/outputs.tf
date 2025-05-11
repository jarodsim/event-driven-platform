output "role_arn" {
  description = "ARN da role básica de Lambda"
  value       = aws_iam_role.basic_lambda.arn
}
