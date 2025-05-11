resource "aws_api_gateway_rest_api" "api" {
  name        = "edp-${var.name}"
  description = "API Gateway compartilhado para os Lambdas"
}
