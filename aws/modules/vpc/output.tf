output "vpc" {
  value = aws_vpc.vpc
}

output "public_subnets" {
  value = aws_subnet.public
}

output "private_subnets" {
  value = aws_subnet.private
}