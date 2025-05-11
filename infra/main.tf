module "event_bridge_bus" {
  source = "./modules/shared/aws_event_bridge/event_bus"
  name   = "${terraform.workspace}-orders"
}

module "basic_lamda_role" {
  source = "./modules/shared/aws_basic_lambda_iam_role"
}

module "api_gateway" {
  source = "./modules/shared/aws_api_gateway"
  name   = "event-driven-platform"
}

# lambdas functions
module "create_order_lambda" {
  source           = "./services/create_order"
  region           = var.region
  lambda_role_arn  = module.basic_lamda_role.role_arn
  rest_api_id      = module.api_gateway.rest_api_id
  root_resource_id = module.api_gateway.root_resource_id
  execution_arn    = module.api_gateway.execution_arn
}

module "invoice_order_lambda" {
  source          = "./services/invoice_order"
  region          = var.region
  lambda_role_arn = module.basic_lamda_role.role_arn
}

module "notificate_order_lambda" {
  source          = "./services/notificate_order"
  region          = var.region
  lambda_role_arn = module.basic_lamda_role.role_arn
}

module "validate_order_lambda" {
  source          = "./services/validate_order"
  region          = var.region
  lambda_role_arn = module.basic_lamda_role.role_arn
}




module "api_gateway_deployment" {
  source = "./modules/shared/aws_api_gateway_deployment"

  rest_api_id          = module.api_gateway.rest_api_id
  stage_name           = terraform.workspace
  region               = var.region
  depends_on_resources = [module.create_order_lambda]
}

