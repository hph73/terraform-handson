variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    "us-east-1" = "ami-0360c520857e3138f"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdf"
}
