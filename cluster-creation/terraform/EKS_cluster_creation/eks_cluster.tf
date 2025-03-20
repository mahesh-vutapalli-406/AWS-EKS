resource "aws_eks_cluster" "example" {
  name = "eks-cluster-tf"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster_role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      module.subnet-1.subnetid_private1,
      module.subnet-1.subnetid_public1,
      module.subnet-2.subnetid_public1
    ]
  }
  tags = {
    Name = "eks-cluster-tf"
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    module.subnet-1, module.subnet-2, module.vpc_creation, aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

