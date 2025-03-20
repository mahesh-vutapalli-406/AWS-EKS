output "subnetid_private1" {
  value = aws_subnet.private_1.id
}

output "subnetid_public1" {
  value = aws_subnet.public_1.id
}

# output "subnetid_secondary_public1" {
#   value = aws_subnet.public_1_in_econdary_cidr[0].id
# }

# output "subnetid_secondary_private1" {
#   value = aws_subnet.private_1_in_econdary_cidr[0].id
# }