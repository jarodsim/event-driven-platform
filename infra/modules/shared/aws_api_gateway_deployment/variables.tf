variable "rest_api_id" {
  type = string
}

variable "stage_name" {
  type        = string
  description = "Nome do stage (ex: dev, prod)"
}

variable "depends_on_resources" {
  description = "Lista de recursos que precisam existir antes do deploy (ex: métodos, integrações)"
  type        = list(any)
  default     = []
}


variable "region" {
  type = string
}
