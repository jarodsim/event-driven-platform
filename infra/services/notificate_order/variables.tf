variable "lambda_role_arn" {
  description = "ARN do role do Lambda"
  type        = string
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}
