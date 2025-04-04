
resource "aws_launch_template" "eks_node_lt" {
  name_prefix   = "eks-node-lt"
  instance_type = "t3.medium" # or whatever instance type you're using

  vpc_security_group_ids = [
    aws_security_group.eks_node_group_sg.id
  ]
}

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "eks-cluster-tf-node-group"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = [module.subnet-1.subnetid_public1, module.subnet-2.subnetid_public1]
  #instance_types  = ["t3.medium"]
  remote_access {
    ec2_ssh_key               = aws_key_pair.eks-ssh.key_name
    source_security_group_ids = [aws_security_group.eks_node_group_sg.id]
  }
  launch_template {
    id      = aws_launch_template.eks_node_lt.id
    version = "$Latest"
  }
  // Configure scaling options for the node group
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
  // Ensure that the creation of the node group depends on the IAM role policies being attached
  depends_on = [
    module.subnet-1,
    module.subnet-2,
    module.vpc_creation,
    aws_eks_cluster.example,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_launch_template.eks_node_lt,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}