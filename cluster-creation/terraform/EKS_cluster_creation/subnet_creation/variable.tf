variable "vpc_name" {
  default = "practice-vpc"
}

variable "vpc_id" {
  default = "vpc-123456789"
}

variable "private_subnet_cidr_1" {
}

variable "enable_secondary_cidr" {
  default = true
}
variable "secondary_cidr_vpc_id" {
  default = "180.0.0.0/16"
}

variable "secondary_cidr_private_cidr_1" {
  default = "180.0.0.0/24"
}

variable "public_subnet_cidr_1" {
}

variable "secondary_cidr_public_cidr_1" {
  default = "180.0.2.0/24"

}
variable "aws_region" {
  default = "us-east-1"
}