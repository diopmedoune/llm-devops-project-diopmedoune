variable "secret_name" {
  type        = string
  description = "Nom du secret dans AWS Secrets Manager"
}

variable "description" {
  type        = string
  description = "Description du secret"
  default     = ""
}

variable "secret_data" {
  type        = map(string)
  description = "Contenu sensible à stocker au format JSON"
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags à associer au secret"
  default     = {}
}
