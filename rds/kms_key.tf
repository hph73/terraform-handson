resource "aws_kms_key" "mykey" {
  description             = "my kms key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags = {
    Name = "aws_secrets_manager"
  }
}