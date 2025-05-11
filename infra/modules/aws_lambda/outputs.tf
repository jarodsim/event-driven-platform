output "name" {
  description = "Nome da função Lambda"
  value       = aws_lambda_function.lambda.function_name

}

output "arn" {
  description = "ARN da função Lambda"
  value       = aws_lambda_function.lambda.arn
}

