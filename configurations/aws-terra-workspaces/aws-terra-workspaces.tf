provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  type = "map"
  default = {
    default = "t2.nano"
    dev     = "t2.micro"
    prd     = "t2.large"
  }
}

resource "aws_instance" "k8s-masters" {
  ami           = "ami-0817d428a6fb68645"
  instance_type = lookup(var.instance_type, terraform.workspace)
}

module "consul" {
  sourve = "../consul"
}

module "vpc" {
  source = "git::https://example.com/vpc.git"
}

module "storage" {
  source = "git::ssh://username@example.com/storage.git"
}

