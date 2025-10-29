resource "random_password" "my_password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "example" {
  name                    = "rds_admin7"
  kms_key_id              = aws_kms_key.mykey.id
  recovery_window_in_days = 14
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = random_password.my_password.result
}