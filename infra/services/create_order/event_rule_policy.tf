data "aws_caller_identity" "current" {}

module "put_events_policy" {
  source = "../../modules/shared/aws_iam_policy"
  name   = "${module.lambda.name}-put-events"
  policy_json = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "events:PutEvents",
        Resource = "arn:aws:events:${var.region}:${data.aws_caller_identity.current.account_id}:event-bus/edp-${terraform.workspace}-orders"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_put_events" {
  role       = "edp-${terraform.workspace}-basic-lambda-role"
  policy_arn = module.put_events_policy.arn
}
