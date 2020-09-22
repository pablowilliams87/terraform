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
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0999a08651c572b91"]
  subnet_id              = "subnet-0bceecd29dfc11230"
}
