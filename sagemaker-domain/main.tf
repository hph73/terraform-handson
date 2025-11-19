resource "aws_sagemaker_domain" "example-dm" {
  domain_name = "my-domain"
  auth_mode   = "IAM"
  vpc_id      = aws_vpc.main.id
  subnet_ids  = [aws_subnet.main.id]

  default_user_settings {
    execution_role = aws_iam_role.sagemaker_role.arn
  }
}

resource "aws_sagemaker_user_profile" "example" {
  domain_id         = aws_sagemaker_domain.example-dm.id
  user_profile_name = "example-profile"
}

resource "aws_sagemaker_pipeline" "example-pipeline" {
  pipeline_name         = "example-pipeline"
  pipeline_display_name = "example-pipeline"
  role_arn              = aws_iam_role.sagemaker_role.arn

  pipeline_definition = jsonencode({
    Version = "2020-12-01"
    Steps = [{
      Name = "Test"
      Type = "Fail"
      Arguments = {
        ErrorMessage = "test"
      }
    }]
  })
}