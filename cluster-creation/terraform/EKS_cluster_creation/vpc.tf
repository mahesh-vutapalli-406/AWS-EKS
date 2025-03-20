module "vpc_creation" {
  source                = "./vpc_creation"
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  aws_region            = var.aws_region
  enable_secondary_cidr = false
}

variable "vpc_cidr" {
  default = "180.0.0.0/16"
}

variable "vpc_name" {
  default = "eks_cluster_vpc"
}

