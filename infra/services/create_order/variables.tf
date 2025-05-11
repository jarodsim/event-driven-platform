variable "lambda_role_arn" {
  description = "ARN do role do Lambda"
  type        = string
}

variable "rest_api_id" {
  description = "ID do API Gateway"
  type        = string
}

variable "root_resource_id" {
  description = "ID do recurso raiz do API Gateway"
  type        = string
}

variable "execution_arn" {
  type = string
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}
