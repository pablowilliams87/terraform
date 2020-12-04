resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = "/aws/eks/${var.eks_cluster_name}/cluster"
  retention_in_days = var.eks_log_retention_cluster
}

resource "aws_cloudwatch_log_group" "eks_clusterinsight" {
  name              = "/aws/containerinsights/${var.eks_cluster_name}/performance"
  retention_in_days = var.eks_log_retention_cluster
}

resource "aws_cloudwatch_log_group" "eks_fluentbit" {
  name              = "/aws/eks/${var.eks_cluster_name}/fluentbit-cloudwatch/logs"
  retention_in_days = var.eks_log_retention_containers
}

resource "helm_release" "aws_cloudwatch_metrics" {
  depends_on = [aws_cloudwatch_log_group.eks_clusterinsight, null_resource.configure_kubectl]
  name       = "aws-cloudwatch-metrics"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-cloudwatch-metrics"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }
}

resource "helm_release" "aws_for_fluent_bit" {
  depends_on = [aws_cloudwatch_log_group.eks_fluentbit, null_resource.configure_kubectl]
  name       = "aws-for-fluent-bit"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-for-fluent-bit"
  namespace  = "kube-system"

  set {
    name  = "cloudWatch.enabled"
    value = true
  }

  set {
    name  = "cloudWatch.region"
    value = var.region
  }


  set {
    name  = "cloudWatch.logGroupName"
    value = "/aws/eks/${var.eks_cluster_name}/fluentbit-cloudwatch/logs"
  }

  set {
    name  = "firehose.enabled"
    value = false
  }

  set {
    name  = "kinesis.enabled"
    value = false
  }

  set {
    name  = "elasticsearch.enabled"
    value = false
  }

}