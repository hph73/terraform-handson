data "archive_file" "example" {
  type        = "zip"
  source_file = "${path.module}/code.py"
  output_path = "${path.module}/code.zip"
}

resource "aws_lambda_function" "my_lambda" {
  filename         = data.archive_file.example.output_path
  function_name    = "my_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "code.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.example.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.my-table.name
    }
  }
}