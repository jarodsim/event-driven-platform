resource "aws_sqs_queue" "sqs" {
  name = "edp-${terraform.workspace}-${var.name}"
}

