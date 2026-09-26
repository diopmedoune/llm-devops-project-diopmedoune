project_name       = "cloud-project"
environment        = "dev"
aws_region         = "us-east-1"
secret_description = "Identifiants et tokens de configuration de l'application"

app_secrets = {
  api_key     = "secret-api-key-12345"
  db_user     = "app_admin"
  db_password = "super-secret-password"
}
