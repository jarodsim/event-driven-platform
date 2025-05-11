module "event_rule" {
  source         = "../../modules/aws_event_bridge/event_rule"
  description    = "Event rule for invoice order"
  event_bus_name = "edp-${terraform.workspace}-orders"

  event_pattern = {
    "source" : ["edp.orders"],
    "detail-type" : ["OrderCreated"]
  }

  name            = "invoice-order"
  target_arn      = module.lambda.arn
  target_type     = "lambda"
  dead_letter_arn = module.sqs.arn
}
