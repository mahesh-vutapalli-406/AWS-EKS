output "vpc_id" {
  value = aws_vpc.practice_vpc.id
}

output "secondary_vpc_id" {
  value = var.enable_secondary_cidr ? aws_vpc_ipv4_cidr_block_association.secondary_cidr[0].vpc_id : null
}