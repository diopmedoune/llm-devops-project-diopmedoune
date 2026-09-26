variable "aws_region" {
  type        = string
  description = "Région AWS simulée"
  default     = "us-east-1"
}

variable "floci_endpoint" {
  type        = string
  description = "Endpoint de l'émulateur Floci local"
  default     = "http://localhost:4566"
}

variable "project_name" {
  type        = string
  description = "Nom du projet"

  validation {
    condition     = length(var.project_name) > 2
    error_message = "Le nom du projet doit contenir au moins 3 caractères."
  }
}

variable "environment" {
  type        = string
  description = "Environnement cible (ex: dev, prod)"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "L'environnement doit être dev, staging ou prod."
  }
}

variable "secret_description" {
  type        = string
  description = "Description du secret stocké dans Secrets Manager"
  default     = "Identifiants applicatifs gérés par Terraform"
}

variable "app_secrets" {
  type        = map(string)
  description = "Paires clé-valeur des secrets applicatifs à chiffrer"
  sensitive   = true
}
