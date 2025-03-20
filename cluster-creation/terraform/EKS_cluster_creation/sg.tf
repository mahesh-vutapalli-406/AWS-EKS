# resource "aws_security_group" "eks_ssh_access" {
#   depends_on  = [module.vpc_creation]
#   name        = "eks-ssh-access"
#   description = "Allow SSH access to EKS worker nodes from my IP"
#   vpc_id      = module.vpc_creation.vpc_id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [local.cidr_ipv4]
#   }
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["180.0.0.0/16"]
#   }

#   tags = {
#     Name = "eks-ssh-access"
#   }
# }

resource "aws_security_group" "eks_node_group_sg" {
  name        = "eks-node-group-sg"
  description = "Security group for EKS Node Group"
  vpc_id      = module.vpc_creation.vpc_id

  # Inbound Rules
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.cidr_ipv4]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["180.0.0.0/16"]
  }

  ingress {
    description = "Allow HTTPS from EKS Cluster"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["180.0.0.0/16"]
  }

  ingress {
    description = "Allow Kubelet API communication"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks =  ["180.0.0.0/16"]
  }

  # Outbound Rules
  egress {
    description = "Allow outbound HTTPS to AWS services"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound DNS resolution"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-node-group-sg"
  }
}


data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  cidr_ipv4 = "${chomp(data.http.myip.response_body)}/32"
}