resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "kwa-aline-vpc"
  }
}
// provides a resource to create a VPC internet gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "kwa-internet-gw"
  }
}
//eip and aws_nat_gateway build up the NAT gateway
resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.private.id

  tags = {
    Name = "kwa-nat-gw"
  }
  depends_on = [aws_internet_gateway.gateway]
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.public_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name = "kwa-public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.private_subnet_az

  tags = {
    Name = "kwa-private-subnet"
  }
}
//add route
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "kwa-public-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "kwa-private-rt"
  }
}
//association between route table and subnet
resource "aws_route_table_association" "public_rta" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rta" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}
