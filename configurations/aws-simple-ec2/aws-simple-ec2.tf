terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t3.micro"
}

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
}

resource "aws_security_group" "allow_tls" {
  name = "allow_tls"
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
  }
}


output "ec2-pub-ip" {
  value = aws_instance.myec2.public_ip
}


/*
resource "aws_instance" "myec2_2" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t3.micro"
}
*/