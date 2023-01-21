resource "random_id" "id" {
  byte_length = 4
}

resource "aws_kms_key" "kms_key" {
  customer_master_key_spec = var.master_key_spec
  description              = "Key used for SecretsManager: ${var.secret_manager_name}"
  deletion_window_in_days  = 10
  tags                     = var.secrets_tags
}

resource "aws_kms_alias" "kms_key_alias" {
  name          = "alias/mambu-${var.secret_manager_name}"
  target_key_id = aws_kms_key.kms_key.key_id
}

resource "aws_secretsmanager_secret" "secrets" {
  name       = var.secret_manager_name
  kms_key_id = aws_kms_key.kms_key.key_id
  tags       = var.secrets_tags
  dynamic "replica" {
    for_each = var.replication ? list([0]) : []
    content {
      region     = var.region_replication
      kms_key_id = null
    }
  }
  depends_on = [aws_kms_key.kms_key]
}

resource "aws_secretsmanager_secret_version" "secrets_version" {
  secret_id     = aws_secretsmanager_secret.secrets.id
  secret_string = var.secrets_manager_values != null ? jsonencode(var.secrets_manager_values) : (var.secrets_manager_string != null ? var.secrets_manager_string : null)
  lifecycle {
    ignore_changes = [
      secret_string,
    ]
  }
  depends_on = [aws_secretsmanager_secret.secrets]
}
