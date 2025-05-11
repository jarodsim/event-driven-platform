resource "aws_lambda_function" "lambda" {
  function_name    = "edp-${terraform.workspace}-${var.name}"
  role             = var.role_arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.zip_path
  source_code_hash = filebase64sha256(var.zip_path)
  timeout          = var.timeout
  memory_size      = var.memory_size


  tags = {
    Name        = "edp-${terraform.workspace}-${var.name}"
    Environment = terraform.workspace
    Project     = "edp"
  }

  environment {
    variables = var.environment_variables
  }
}
