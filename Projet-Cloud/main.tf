module "s3" {
  source = "./modules/s3"

  bucket_name = "${local.resource_prefix}-data-bucket"
  tags        = local.common_tags
}

module "secrets_manager" {
  source = "./modules/secrets_manager"

  secret_name = "${local.resource_prefix}-app-secrets"
  description = var.secret_description
  secret_data = var.app_secrets
  tags        = local.common_tags
}
