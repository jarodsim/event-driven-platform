variable "name" {
  description = "Nome da role"
  type        = string
}

variable "description" {
  description = "Descrição da role"
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "Trust policy da role"
  type        = string
}

variable "managed_policy_arns" {
  description = "Lista de ARNs de policies gerenciadas para anexar"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = <<EOT
Lista de inline policies, cada uma no formato:
{
  description = string (opcional),
  statements  = list(object({
    Effect   = string
    Action   = list(string)
    Resource = string or list(string)
  }))
}
EOT
  type = list(object({
    description = optional(string)
    statements = list(object({
      Effect   = string
      Action   = list(string)
      Resource = any
    }))
  }))
  default = []
}
