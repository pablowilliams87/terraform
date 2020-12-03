resource "null_resource" "configure_kubectl" {
  depends_on = [aws_eks_node_group.eks_node]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name eks-ops"
  }
}


resource "helm_release" "cluster_autoscaler" {
  depends_on = [null_resource.configure_kubectl]
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  //  version    = "1.1.1"

  set {
    name  = "nameOverride"
    value = "cluster-autoscaler"
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.enabled"
    value = "true"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "image.repository"
    value = "k8s.gcr.io/autoscaling/cluster-autoscaler"
  }

  set {
    name  = "image.tag"
    value = "v1.18.2"
  }


  /*
  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "sslCertPath"
    value = "/etc/ssl/certs/ca-bundle.crt"
  }
*/
}

