output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificat_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority
}

output "generate_kubectl_context" {
  value = "aws eks update-kubeconfig --name ${var.eks_cluster_name}"
}
