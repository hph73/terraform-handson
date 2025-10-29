resource "aws_key_pair" "deployer" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}