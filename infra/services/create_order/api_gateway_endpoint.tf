module "api_gateway_endpoint" {
  source = "../../modules/shared/aws_api_gateway_lambda_integration"

  rest_api_id        = var.rest_api_id
  parent_resource_id = var.root_resource_id
  execution_arn      = var.execution_arn
  region             = var.region

  lambda_arn  = module.lambda.arn
  lambda_name = module.lambda.name
  path        = "order"
  method      = "POST"
}
