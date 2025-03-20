# Replace with your AWS Root Account ID
data "aws_caller_identity" "current" {}



# IAM Role to be assumed by the root account
resource "aws_iam_role" "eks_access_role" {
  name = "EKSAccessRole-terraform"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Policy for EKS Access
resource "aws_iam_policy" "eks_access_policy" {
  name        = "EKSAccessPolicy"
  description = "Policy granting full access to the EKS cluster"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "eks_access_attachment" {
  depends_on = [aws_iam_policy.eks_access_policy, aws_iam_role.eks_access_role]
  policy_arn = aws_iam_policy.eks_access_policy.arn
  role       = aws_iam_role.eks_access_role.name
}

# EKS Access Entry to Allow the Role Access to Cluster

resource "aws_eks_access_entry" "example" {
  cluster_name  = aws_eks_cluster.example.name
  principal_arn = aws_iam_role.eks_access_role.arn
  type          = "STANDARD"

  depends_on = [aws_iam_role.eks_access_role]
}

# Associate IAM Role with EKS Access Policy

resource "aws_eks_access_policy_association" "eks_admin_access" {
  depends_on    = [aws_eks_cluster.example, aws_iam_role.eks_access_role]
  cluster_name  = aws_eks_cluster.example.name
  principal_arn = aws_iam_role.eks_access_role.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  # Required block: Defines the access scope
  access_scope {
    type = "cluster" # or use "namespace" if you need to restrict access
  }
}