resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_subnet
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.environment}-eks-vpc"
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "${var.environment}-eks-igw"
  }
}

resource "aws_subnet" "eks_routing" {
  count = length(var.eks_subnets)

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = element(values(var.eks_subnets), count.index)
  availability_zone       = element(keys(var.eks_subnets), count.index)
  map_public_ip_on_launch = true
  tags = {
    Name                                            = "${var.environment}-eks-${count.index}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}

resource "aws_route_table" "eks_routing" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
  tags = {
    Name = "${var.environment}-eks"
  }
}

resource "aws_route_table_association" "eks_routing" {
  count = length(var.eks_subnets)

  subnet_id      = element(aws_subnet.eks_routing.*.id, count.index)
  route_table_id = aws_route_table.eks_routing.id
}

