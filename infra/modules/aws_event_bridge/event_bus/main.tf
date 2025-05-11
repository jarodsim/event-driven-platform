resource "aws_cloudwatch_event_bus" "this" {
  name = "edp-${var.name}"
}
