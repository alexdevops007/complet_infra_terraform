data "aws_availability_zones" "availability_zones" {}

resource "aws_subnet" "private_subnet" {
  vpc_id = var.vpc-id
  cidr_block = cidrsubnet(var.vpc-cidr, 8, 2)
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private subnet"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.vpc-nat_gateway-id
  }

  tags = {
    Name = "private route table"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}