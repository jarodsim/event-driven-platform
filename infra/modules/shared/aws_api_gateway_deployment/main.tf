resource "aws_api_gateway_deployment" "this" {
  depends_on  = [var.depends_on_resources]
  rest_api_id = var.rest_api_id

  triggers = {
    redeploy = uuid()
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  stage_name    = var.stage_name
  rest_api_id   = var.rest_api_id
  deployment_id = aws_api_gateway_deployment.this.id
}


