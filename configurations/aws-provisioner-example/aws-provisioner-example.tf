terraform {
  backend "s3" {
    bucket     = "tfstates-bucket"
    key        = "demo.tfstate"
    region     = "us-east-1"
    access_key = "XXXXX"
    secret_key = "YYYY"
  }
}

provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::822222060123:role/pablow-sts"
  }
}

provider "aws" {
  region = "us-west-2"
  alias = "west"
}

resource "aws_eip" "myeip" {
  vpc = "true"
}

resource "aws_eip" "mywesteip" {
  vpc = "true"
  provider = "aws.mumbai"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  key_name      = "terraform"
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = "file(./terraform)"
  }
}


resource "aws_instance" "web" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
  }
}


resource "aws_instance" "web" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
  }
  provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo yum -y remove nano"
    ]
  }
}


variable "instance_type" {
  default = "t2.micro"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = var.instance_type
}


module "myec2" {
  source        = "../../project1/ec2"
  instance_type = "t2.large"
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.13.0"
  # insert the 10 required variables here
}

module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "my-cluster"
  instance_count = 5

  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}