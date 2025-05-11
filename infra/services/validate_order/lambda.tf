data "aws_caller_identity" "current" {}

locals {
  lambda_name = "ValidateOrder"
}

module "lambda" {
  source = "../../modules/aws_lambda"

  name        = local.lambda_name
  handler     = "lambda_function.handler"
  runtime     = "python3.12"
  zip_path    = "${path.module}/../../../lambdas/${local.lambda_name}/${local.lambda_name}.zip"
  timeout     = 10
  memory_size = 128
  role_arn    = var.lambda_role_arn
  environment_variables = {
    DLQ_URL : "https://sqs.${var.region}.amazonaws.com/${data.aws_caller_identity.current.account_id}/edp-${terraform.workspace}-${local.lambda_name}-dlq"
  }
}
