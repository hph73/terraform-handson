resource "aws_s3_bucket" "s3-mybucket" {
  bucket = "mybucket-hao-test-10132025"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}