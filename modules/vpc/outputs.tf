# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.EKS_VPC.id
}


# Public subnet Id
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public[*].id
}


# Private subnet Id
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private[*].id
}


