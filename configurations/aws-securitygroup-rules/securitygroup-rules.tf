variable "vpn_ip" {
  default = "195.123.44.5/32"
}

resource "aws_security_group" "var_demo" {
  name = "sec-group-1"
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }
}