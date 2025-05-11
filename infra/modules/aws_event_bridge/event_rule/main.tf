resource "aws_cloudwatch_event_rule" "this" {
  name           = "edp-${terraform.workspace}-${var.name}"
  description    = var.description
  event_bus_name = var.event_bus_name

  event_pattern = var.event_pattern != null ? jsonencode(var.event_pattern) : null

  schedule_expression = var.schedule_expression != null ? var.schedule_expression : null
}

resource "aws_cloudwatch_event_target" "this" {
  rule     = aws_cloudwatch_event_rule.this.name
  arn      = var.target_arn
  role_arn = var.target_type == "lambda" ? aws_iam_role.eventbridge_lambda_role[0].arn : null
  event_bus_name = var.event_bus_name

  dead_letter_config {
    arn = var.dead_letter_arn == null ? null : var.dead_letter_arn
  }

  depends_on = [
    aws_cloudwatch_event_rule.this
  ]
}

resource "aws_iam_role" "eventbridge_lambda_role" {
  count = var.target_type == "lambda" ? 1 : 0

  name = "${var.name}-invoke-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "events.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "invoke_lambda_policy" {
  count = var.target_type == "lambda" ? 1 : 0

  name = "${var.name}-lambda-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "lambda:InvokeFunction"
      Resource = var.target_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  count      = var.target_type == "lambda" ? 1 : 0
  role       = aws_iam_role.eventbridge_lambda_role[0].name
  policy_arn = aws_iam_policy.invoke_lambda_policy[0].arn
}
