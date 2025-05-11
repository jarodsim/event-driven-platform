module "lambda" {
  source = "../../modules/aws_lambda"

  name        = "CreateOrder"
  handler     = "lambda_function.handler"
  runtime     = "python3.12"
  zip_path    = "${path.module}/../../../lambdas/CreateOrder/CreateOrder.zip"
  timeout     = 10
  memory_size = 128
  environment_variables = {
    EVENT_BUS_NAME = "edp-${terraform.workspace}-orders"
  }
  role_arn = var.lambda_role_arn
}
