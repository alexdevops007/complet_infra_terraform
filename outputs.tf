# VPC
output "vpc-id" {
  value = module.vpc_1_subnet_public.vpc_id
}

# NAT Gateway Public IP
output "public_ip_ig" {
  value = module.vpc_1_subnet_public.public_ip_nat_gateway
}

# Internet Gateway
output "internet-gateway" {
  value = module.vpc_1_subnet_public.internet_gateway
}

# Nat Gateway ID
output "nat_gateway-id" {
  value = module.vpc_1_subnet_public.nat_gateway_id
}

# Subnet ID
output "subnet-id" {
  value = module.vpc_1_subnet_public.subnet_id
}