resource "aws_sagemaker_notebook_instance" "ni" {
  name          = "my-notebook-instance"
  role_arn      = aws_iam_role.sagemaker_role.arn
  instance_type = "ml.t2.medium"
  default_code_repository = aws_sagemaker_code_repository.sm_repo.code_repository_name

  tags = {
    Name = "foo"
  }
}

resource "aws_sagemaker_code_repository" "sm_repo" {
  code_repository_name = "my-notebook-instance-code-repo"

  git_config {
    repository_url = "https://github.com/hph73/SageMaker-Pytorch.git"
  }
}
