variable "aws_provider_version" {
  default     = "5.91.0"
  type        = string
  description = "aws provider version block. Please check it before apply the changes"
}

variable "vpc_cidr" {
  default     = "160.10.0.0/16"
  description = "default vpc cidr range for VPC"
  type        = string
}

variable "vpc_name" {
  default     = "practice_vpc"
  description = "VPC default name"
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "default aws region"
  type        = string
}

variable "secondary_vpc_cidr" {
  default     = "190.10.0.0/16"
  description = "default secondary vpc cidr range for VPC"
  type        = string
}

variable "enable_secondary_cidr" {
  default     = true
  description = "flag to enable the secondary cidr"
  type        = bool
}