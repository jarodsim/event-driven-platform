variable "name" {
  description = "Nome da função Lambda"
  type        = string

}

variable "handler" {
  description = "Handler da função Lambda"
  type        = string
}

variable "runtime" {
  description = "Runtime da função Lambda"
  type        = string
}

variable "zip_path" {
  description = "Caminho do arquivo zip da função Lambda"
  type        = string
}

variable "environment_variables" {
  description = "Variáveis de ambiente da função Lambda"
  type        = map(string)
  default     = {}
}
variable "role_arn" {
  description = "ARN da role do Lambda"
  type        = string
}

variable "memory_size" {
  description = "Tamanho da memória da função Lambda"
  type        = number
  default     = 128

}

variable "timeout" {
  description = "Timeout da função Lambda"
  type        = number
  default     = 3
}
