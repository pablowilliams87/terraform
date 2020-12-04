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

variable "eks_k8s_version" {
  description = "AWS K8s Version"
  default     = "1.18.2"
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
  # Desired, Min, Max
  default = [3, 3, 8]
}

variable "eks_node_instance_type" {
  description = "AWS EKS Instance Type"
  default     = "t3.medium"
}

variable "eks_log_retention_cluster" {
  description = "AWS EKS Cluster Log Retention Days"
  default     = "7"
}

variable "eks_log_retention_containers" {
  description = "AWS EKS Containers Log Retention Days"
  default     = "7"
}