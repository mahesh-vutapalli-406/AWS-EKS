
resource "aws_eks_addon" "vpc_cni" {
  depends_on   = [aws_eks_cluster.example]
  cluster_name = aws_eks_cluster.example.name
  addon_name   = "vpc-cni"
  #ddon_version               = "v1.19.0-eksbuild.1"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  depends_on   = [aws_eks_cluster.example]
  cluster_name = aws_eks_cluster.example.name
  addon_name   = "kube-proxy"
  #ddon_version               = "v1.31.3-eksbuild.2"
  resolve_conflicts_on_update = "OVERWRITE"
}

# resource "aws_eks_addon" "coredns" {
#   depends_on   = [aws_eks_node_group.node, aws_eks_cluster.example]
#   cluster_name = aws_eks_cluster.example.name
#   addon_name   = "coredns"
#   addon_version     = "v1.11.4-eksbuild.2"
#   resolve_conflicts_on_update = "OVERWRITE"
# }

# resource "aws_eks_addon" "pod_identity_agent" {
#   depends_on   = [aws_eks_cluster.example, aws_eks_node_group.node]
#   cluster_name = aws_eks_cluster.example.name
#   addon_name   = "amazon-eks-pod-identity-agent"
#   #addon_version               = "v1.3.4-eksbuild.1"
#   resolve_conflicts_on_update = "OVERWRITE"
# }

resource "aws_eks_addon" "cloudwatch_observability" {
  depends_on   = [aws_eks_cluster.example, aws_eks_node_group.node]
  cluster_name = aws_eks_cluster.example.name
  addon_name   = "amazon-cloudwatch-observability"
  #addon_version               = "v3.4.0-eksbuild.1"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name  = aws_eks_cluster.example.name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = "v1.41.0-eksbuild.1" # Use latest supported version
  resolve_conflicts_on_update  = "OVERWRITE"
}

# resource "aws_eks_addon" "kubernetes_dashboard" {
#   cluster_name                = aws_eks_cluster.example.name
#   addon_name                  = "kubernetes-dashboard"
#  #addon_version               = "v2.7.0"
#   resolve_conflicts_on_update = "OVERWRITE"
# }
