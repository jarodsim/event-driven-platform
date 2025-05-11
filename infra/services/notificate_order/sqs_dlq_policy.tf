
module "put_events_policy" {
  source = "../../modules/shared/aws_iam_policy"
  name   = "${module.lambda.name}-dlq"
  policy_json = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sqs:SendMessage",
        Resource = "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${module.lambda.name}-dlq"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_put_events" {
  role       = "edp-${terraform.workspace}-basic-lambda-role"
  policy_arn = module.put_events_policy.arn
}
