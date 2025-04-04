

# # IAM Role for Read-Only EKS Access
# resource "aws_iam_role" "eks_readonly_role" {
#   name = "EKSReadOnlyRole"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# # IAM Policy for Read-Only EKS and Kubernetes Resources (Pods, Deployments, etc.)
# resource "aws_iam_policy" "eks_readonly_policy" {
#   name        = "EKSReadOnlyPolicy"
#   description = "Policy granting read-only access to EKS and Kubernetes resources"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "eks:DescribeCluster",
#           "eks:ListClusters",
#           "eks:DescribeNodegroup",
#           "eks:ListNodegroups",
#           "eks:DescribeFargateProfile",
#           "eks:ListFargateProfiles",
#           "eks:DescribeAddon",
#           "eks:ListAddons",
#           "eks:DescribeKubernetesVersion",
#           "eks:ListKubernetesVersions",
#           "eks:AccessKubernetesApi"
#         ]
#         Resource = "*"
#       },
#       {
#         Effect = "Allow"
#         Action = [
#           "ec2:DescribeInstances",
#           "ec2:DescribeSubnets",
#           "ec2:DescribeVpcs",
#           "ec2:DescribeSecurityGroups"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# # Attach IAM Policy to IAM Role
# resource "aws_iam_role_policy_attachment" "eks_readonly_attachment" {
#   policy_arn = aws_iam_policy.eks_readonly_policy.arn
#   role       = aws_iam_role.eks_readonly_role.name
# }

# # EKS Access Entry to Allow Role to Access Cluster
# resource "aws_eks_access_entry" "eks_readonly_access" {
#   cluster_name         = aws_eks_cluster.example.name
#   principal_arn        = aws_iam_role.eks_readonly_role.arn
#   type                 = "STANDARD"
#   #kubernetes_username  = "eks-readonly-user"  # Define a valid Kubernetes username
# }

# # Kubernetes ConfigMap to Allow IAM Role to See Pods
# # resource "null_resource" "eks_rbac_config" {
# #   provisioner "local-exec" {
# #     command = <<EOT
# #     kubectl get configmap aws-auth -n kube-system -o yaml > aws-auth.yaml
# #     yq eval '.data.mapRoles += "- rolearn: ${aws_iam_role.eks_readonly_role.arn}\\n  username: eks-readonly-user\\n  groups:\\n    - system:aggregate-to-view"' -i aws-auth.yaml
# #     kubectl apply -f aws-auth.yaml
# #     EOT
# #   }
# # }
