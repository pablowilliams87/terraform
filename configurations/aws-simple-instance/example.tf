terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "example" {
  ami                    = "ami-0dba2cb6798deb6d8"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-03e079f768773614c"]
  subnet_id              = "subnet-0b150137b82a7df54"
}
