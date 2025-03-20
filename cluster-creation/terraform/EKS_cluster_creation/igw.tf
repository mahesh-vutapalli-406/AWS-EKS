resource "aws_internet_gateway" "eks-internet-gw" {
  vpc_id = module.vpc_creation.vpc_id

  tags = local.tags
}

resource "aws_route_table" "public" {
  vpc_id = module.vpc_creation.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-internet-gw.id
  }

  tags = local.tags
}

resource "aws_route_table_association" "public" {
  subnet_id      = module.subnet-1.subnetid_public1
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-1"{
  subnet_id      =  module.subnet-2.subnetid_public1
  route_table_id = aws_route_table.public.id
}


locals {
  tags = {
    Name = "eks-cluster-tf"
  }
}

resource "aws_nat_gateway" "eks-nat-2"{
  connectivity_type = "private"
  subnet_id         =  module.subnet-2.subnetid_private1
}

resource "aws_nat_gateway" "eks-nat-1"{
  connectivity_type = "private"
  subnet_id         = module.subnet-1.subnetid_private1
}