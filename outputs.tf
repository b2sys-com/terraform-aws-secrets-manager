output "secrets_manager_arn" {
  description = "Amazon Resource Name (ARN) of the secret"
  value       = aws_secretsmanager_secret.secrets.arn
}

output "secrets_manager_kms_arn" {
  description = "Amazon Resource Name (ARN) of the KMS"
  value       = aws_kms_key.kms_key.arn
}

output "secrets_manager_name" {
  description = "The resulting name of the secret"
  value       = aws_secretsmanager_secret.secrets.name
}
