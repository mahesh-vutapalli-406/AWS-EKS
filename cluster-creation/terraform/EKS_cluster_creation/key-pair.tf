resource "tls_private_key" "eks-ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "eks-ssh" {
  key_name   = "eks-ssh"
  public_key = tls_private_key.eks-ssh.public_key_openssh
}

resource "local_file" "eks-ssh" {
  content         = tls_private_key.eks-ssh.private_key_pem
  filename        = "${path.module}/sshkeys/eks-ssh.pem"
  file_permission = "0600" # Set correct permissions for SSH private key
}

output "private_key_pem" {
  value     = tls_private_key.eks-ssh.private_key_pem
  sensitive = true
}
