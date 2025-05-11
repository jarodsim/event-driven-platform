variable "name" {
  type        = string
  description = "Nome do evento"
}
variable "description" {
  type        = string
  description = "Descrição do evento"
}
variable "event_bus_name" {
  type        = string
  description = "Nome do EventBus"
  default     = "default"
}
variable "target_arn" {
  type        = string
  description = "ARN do target (ex: lambda)"
  default     = null
}
variable "target_type" {
  description = "Tipo do target (ex: lambda)"
  default     = "lambda"
}
variable "event_pattern" {
  type    = any
  default = null
}
variable "schedule_expression" {
  type    = string
  default = null
}

variable "dead_letter_arn" {
  type    = string
  default = null
}

