data "aws_secretsmanager_secret" "example" {
  name       = "rds_admin7"
  depends_on = [aws_secretsmanager_secret.example]
}

data "aws_secretsmanager_secret_version" "secret" {
  secret_id = data.aws_secretsmanager_secret.example.id
}

resource "aws_db_instance" "default" {
  storage_type         = "gp2"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "admin"
  password             = data.aws_secretsmanager_secret_version.secret.secret_string
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = true
}