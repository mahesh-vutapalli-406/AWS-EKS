resource "aws_vpc" "practice_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  count      = var.enable_secondary_cidr ? 1 : 0
  vpc_id     = aws_vpc.practice_vpc.id
  cidr_block = var.secondary_vpc_cidr
}

