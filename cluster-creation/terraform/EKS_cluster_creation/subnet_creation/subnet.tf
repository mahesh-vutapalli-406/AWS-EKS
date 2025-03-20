resource "aws_subnet" "private_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_1
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.vpc_name}-private-subnet-1"
  }
}

resource "aws_subnet" "private_1_in_econdary_cidr" {
  count      = var.enable_secondary_cidr ? 1 : 0
  vpc_id     = var.secondary_cidr_vpc_id
  cidr_block = var.secondary_cidr_private_cidr_1
  tags = {
    Name = "${var.vpc_name}-private-subnet-in-secondary-vpc-cidr-1"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidr_1
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.vpc_name}-public-subnet-1"
  }
}

resource "aws_subnet" "public_1_in_econdary_cidr" {
  count      = var.enable_secondary_cidr ? 1 : 0
  vpc_id     = var.secondary_cidr_vpc_id
  map_public_ip_on_launch = true
  cidr_block = var.secondary_cidr_public_cidr_1
  tags = {
    Name = "${var.vpc_name}-public-subnet-in-secondary-vpc-cidr-1"
  }
}