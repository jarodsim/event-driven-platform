output "event_bus_arn" {
  description = "ARN do barramento de eventos"
  value       = aws_cloudwatch_event_bus.this.arn
}
