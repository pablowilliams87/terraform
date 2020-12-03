provider "aws" {
  region = "us-east-1"
}

variable "ami-image" {
  default = "ami-0817d428a6fb68645"
}

resource "aws_security_group" "allow_ssh" {

  ingress {
    description = "Allow ALL Ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow ALL Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfW21z0xc7gC4/xQBkB1KKBQa3Ox4HWK8Pheu5x+LOQxC6F5frBv8eSd81L5s8k3jRllZWswwEx+ZmfrCkVE5fy86l8II9+FV0wjaohpL3zpOJybUDbH8d+YjrrRcLWfUNVBmhCzF+gDxvBHT9TFW3OCIHqHtfM4UHD89kOx22+o37H/KWdXq4gSan2Z6cju16RH0bqOlXehMTPpPaDr+4c2TfTNBtCBsCO/niktQgq62lKIrJQ05Kh1v9STBqZidzwPmIpJLe+If4uGxk4UM5QnzrcS5+jKcSSWvGZZfeat29aGCyNpfd7wBH7+iiSzmcU4/rKCiv7ByzCBTc+qrp pablow@DESKTOP-K7SL4LU"
}

resource "aws_instance" "k8s-masters" {
  ami                    = var.ami-image
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.mykey.id
  tags = {
    Name = "k8s-master-${count.index}"
  }
  count = 1
}

resource "aws_instance" "k8s-workers" {
  ami                    = var.ami-image
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.mykey.id
  tags = {
    Name = "k8s-worker-${count.index}"
  }
  count = 3
}
/*
output "public-ips-masters" {
  value = aws_instance.k8s-masters[*].public_ip
}

output "public-ips-workers" {
  value = aws_instance.k8s-workers[*].public_ip
}
*/
output "ec2-masters-instances" {
  value = "${formatlist(
    "instance %s public-ip: %s private-ip: %s",
    (aws_instance.k8s-masters[*].tags["Name"]),
    (aws_instance.k8s-masters[*].public_ip),
    (aws_instance.k8s-masters[*].private_ip)
  )}"
}

output "ec2-workers-instances" {
  value = "${formatlist(
    "instance %s public-ip: %s private-ip: %s",
    (aws_instance.k8s-workers[*].tags["Name"]),
    (aws_instance.k8s-workers[*].public_ip),
    (aws_instance.k8s-workers[*].private_ip)
  )}"
}
