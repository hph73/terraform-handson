resource "aws_dynamodb_table" "my-table" {
  name         = "my-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "OrderId"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "OrderId"
    type = "S"
  }

  attribute {
    name = "Email"
    type = "S"
  }

  global_secondary_index {
    name            = "EmailIndex"
    hash_key        = "Email"
    projection_type = "ALL"
  }

  tags = {
    Name = "dynamodb-table-test"
  }
}