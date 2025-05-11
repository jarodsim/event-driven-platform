output "event_rule_arn" {
  description = "ARN das regras do EventBridge"
  value       = aws_cloudwatch_event_rule.this.arn
}

output "name" {
  description = "Nome do evento"
  value       = aws_cloudwatch_event_rule.this.name
}
