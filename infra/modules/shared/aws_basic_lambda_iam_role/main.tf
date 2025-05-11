resource "aws_iam_role" "basic_lambda" {
  name = "edp-${terraform.workspace}-basic-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "basic_lambda_logs" {
  name        = "edp-${terraform.workspace}-basic-lambda-logs-policy"
  description = "Permite que a Lambda grave logs no CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "arn:aws:logs:*:*:*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_logs" {
  role       = aws_iam_role.basic_lambda.name
  policy_arn = aws_iam_policy.basic_lambda_logs.arn
}
