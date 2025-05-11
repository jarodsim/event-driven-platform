module "sqs" {
  source = "../../modules/shared/aws_sqs_queue"
  name   = "${split("-", module.lambda.name)[2]}-dlq"
}


# resource "aws_cloudwatch_event_target" "this" {
#   rule           = module.event_rule.name
#   target_id      = "Invoke${module.lambda.name}Lambda"
#   arn            = module.lambda.arn
#   event_bus_name = "edp-${terraform.workspace}-orders"

#   dead_letter_config {
#     arn = module.sqs.arn
#   }
# }
