resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "${var.app_name}-${var.environment_name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.app_name}-${var.environment_name}-igw"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each          = var.subnets_public
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = var.availability_zones[index(keys(var.subnets_public), each.key)]

  tags = {
    Name = "${var.app_name}-${var.environment_name}-public-${each.key}"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each          = var.subnets_private
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = var.availability_zones[index(keys(var.subnets_private), each.key)]

  tags = {
    Name = "${var.app_name}-${var.environment_name}-private-${each.key}"
  }
}

# Public route table => route to IGW
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.app_name}-${var.environment_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_association" {
  for_each = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

# Private route table => no internet route
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.app_name}-${var.environment_name}-private-rt"
  }
}

resource "aws_route_table_association" "private_association" {
  for_each = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}
