# VPC 
output "vpc_id" {
  value = aws_vpc.mainVPC.id
}

# NAT Gateway Public IP
output "public_ip_nat_gateway" {
  value = aws_nat_gateway.nat_gateway.public_ip
}

# Internet Gateway
output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway.id
}

# Nat Gateway ID
output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}

# Subnet ID
output "subnet_id" {
  value = aws_subnet.publicSubnet_1.id
}