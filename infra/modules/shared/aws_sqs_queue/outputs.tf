output "name" {
  value       = aws_sqs_queue.sqs.name
  description = "Nome da fila SQS"
}

output "arn" {
  value       = aws_sqs_queue.sqs.arn
  description = "ARN da fila SQS"
}
output "url" {
  description = "URL da DLQ"
  value       = aws_sqs_queue.sqs.url
}
