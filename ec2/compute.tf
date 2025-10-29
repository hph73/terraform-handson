# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20250821"]
#   }

#   owners = ["099720109477"] # Canonical
# }

resource "aws_instance" "web" {
  # ami                    = data.aws_ami.ubuntu.id
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.id
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = ["${aws_security_group.allow_sgs.id}"]
  user_data              = <<-EOF
                          #!/bin/bash
                          sudo su
                          apt update
                          apt install -y apache2
                          echo "Hello world" > /var/www/html/index.html
                          EOF
  root_block_device {
    volume_size = 10
  }

  ebs_block_device {
    device_name = var.INSTANCE_DEVICE_NAME
    volume_size = 1
    volume_type = "gp2"
  }

  iam_instance_profile = aws_iam_instance_profile.mybucket-instance-profile.name

  tags = {
    Name = "MyEC2"
  }
}