output "s3_bucket_name" {
  description = "Nom du bucket S3 créé"
  value       = module.s3.bucket_id
}

output "s3_bucket_arn" {
  description = "ARN du bucket S3 créé"
  value       = module.s3.bucket_arn
}

output "secrets_manager_secret_name" {
  description = "Nom du secret créé dans Secrets Manager"
  value       = module.secrets_manager.secret_name
}

output "secrets_manager_secret_arn" {
  description = "ARN du secret créé dans Secrets Manager"
  value       = module.secrets_manager.secret_arn
}
