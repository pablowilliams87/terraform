variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment"
  default     = "ops"
}

variable "vpc_subnet" {
  description = "AWS VPC Subnet"
  default     = "10.10.0.0/16"
}

variable "eks_cluster_name" {
  description = "AWS EKS Cluster Name"
  default     = "eks-ops"
}

variable "eks_subnets" {
  description = "Public Subnets"
  default = {
    us-east-1a = "10.10.10.0/24",
    us-east-1b = "10.10.11.0/24",
    us-east-1b = "10.10.12.0/24"
  }
}

variable "eks_node_instances" {
  description = "AWS EKS Instances Count"
  # Desired, Max, Min
  default = [3, 3, 3]
}

variable "eks_node_instance_type" {
  description = "AWS EKS Instance Type"
  default     = "t2.micro"
}