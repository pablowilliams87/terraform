resource "aws_eks_cluster" "eks_cluster" {
  depends_on = [aws_cloudwatch_log_group.eks_cluster]

  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids = aws_subnet.eks_routing[*].id
  }

  tags = {
    Name = "${var.environment}-eks"
  }
}


resource "aws_eks_node_group" "eks_node" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.environment}-eks-node"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = aws_subnet.eks_routing[*].id
  instance_types  = [var.eks_node_instance_type]

  scaling_config {
    desired_size = var.eks_node_instances[0]
    min_size     = var.eks_node_instances[1]
    max_size     = var.eks_node_instances[2]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEC2CloudWatchAgent
  ]
}