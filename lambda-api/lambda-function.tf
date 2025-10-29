resource "aws_lambda_function" "my_lambda" {
  filename      = "${path.module}/code.zip"
  function_name = "my_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "code.lambda_handler"
  runtime       = "python3.9"
}