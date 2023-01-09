# VPC
resource "aws_vpc" "mainVPC" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc-name
  }
}

## Subnet public
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.mainVPC.id

  tags = {
    Name = "Internet Gateway"
  }
}

### Passerelle NAT
resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name = "My EIP"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.publicSubnet_1.id

  tags = {
    Name = "My Nat Gateway"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

### data source of az
data "aws_availability_zones" "availability_zones" {}

### public subnet 1
resource "aws_subnet" "publicSubnet_1" {
  vpc_id = aws_vpc.mainVPC.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 1)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.availability_zones.names[0]

  tags = {
    Name = var.public_subnet_1_name
  }
}

### route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.mainVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public route table"
  }
}

### route table association
resource "aws_route_table_association" "route_table_association" {
  subnet_id = aws_subnet.publicSubnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}
