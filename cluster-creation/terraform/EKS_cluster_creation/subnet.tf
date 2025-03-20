module "subnet-1" {
  depends_on            = [module.vpc_creation]
  source                = "./subnet_creation"
  vpc_name              = var.vpc_name
  vpc_id                = module.vpc_creation.vpc_id
  private_subnet_cidr_1 = var.private_subnet_cidr_1
  enable_secondary_cidr = false
  public_subnet_cidr_1  = var.public_subnet_cidr_1
  aws_region            = var.aws_region
}

module "subnet-2" {
  depends_on            = [module.vpc_creation]
  source                = "./subnet_creation"
  vpc_name              = var.vpc_name
  vpc_id                = module.vpc_creation.vpc_id
  private_subnet_cidr_1 = var.private_subnet_cidr_2
  enable_secondary_cidr = false
  public_subnet_cidr_1  = var.public_subnet_cidr_2
  aws_region            = var.aws_region
}

variable "private_subnet_cidr_1" {
  default = "180.0.0.0/24"
}

variable "public_subnet_cidr_1" {
  default = "180.0.4.0/24"
}

variable "private_subnet_cidr_2" {
  default = "180.0.2.0/24"
}

variable "public_subnet_cidr_2" {
  default = "180.0.3.0/24"
}