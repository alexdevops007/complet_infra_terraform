data "aws_availability_zones" "availability_zones" {}

resource "aws_subnet" "second_subnet_public" {
  vpc_id = var.vpc-id
  cidr_block = cidrsubnet(var.vpc-cidr, 8, 3)
  availability_zone = data.aws_availability_zones.availability_zones.names[2]
  map_public_ip_on_launch = true

  tags = {
    Name = "second subnet public"
  }
}

resource "aws_route_table" "second_route_table" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.vpc-nat_gateway-id
  }

  tags = {
    Name = "second route table"
  }
}

resource "aws_route_table_association" "second_route_table_association" {
  subnet_id = aws_subnet.second_subnet_public.id
  route_table_id = aws_route_table.second_route_table.id
}