resource "tls_private_key" "example" {
  algorithm   = "RSA"
}

resource "local_file" "private_key_pem" {
    content = tls_private_key.example.private_key_pem
    filename = "my_aws_key.pem"
}