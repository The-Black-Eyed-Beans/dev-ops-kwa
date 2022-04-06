output "vpc_id" {
  value = aws_vpc.main.id
  description = "VPC ID for project"
}

output "public_subnet" {
  value = aws_subnet.public
  description = "Public Subnet of VPC"
}

output "private_subnet" {
  value = aws_subnet.private
  description = "Private Subnet of VPC"
}

output "public_subnet_id" {
  value = aws_subnet.public.id
  description = "Public Subnet ID"
}

output "private_subnet_id" {
  value = aws_subnet.private.id
  description = "Private Subnet ID"
}