# VPC Configuration
resource "aws_vpc" "EKS_VPC" {
  cidr_block       = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Project = "EKS-CLUSTER"
    Environment = "Dev"
  }
}

# Public subnet

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.EKS_VPC.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true


  tags = {
    Name = "public-subnet-${count.index + 1}"
    tier = "public"
  }
}


# Private subnet

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.EKS_VPC.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true


  tags = {
    Name = "private-subnet-${count.index + 1}"
    tier = "private"
  }
}

#Internet gateway

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.EKS_VPC.id

  tags = {
    Name = "IGW"
  }
}


# Elastic IP

resource "aws_eip" "eip_nat" {
  count = length(var.public_subnet_cidr)
  domain   = "vpc"
}

# NAT Gateway

resource "aws_nat_gateway" "NAT-GW" {
  count = length(var.public_subnet_cidr)
  allocation_id = aws_eip.eip_nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "nat-gw-${count.index + 1}"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.EKS_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "Public-RT"
  }
}


resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.EKS_VPC.id
  count = length(var.private_subnet_cidr)

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GW[count.index].id
  }

  tags = {
    Name = "private-RT-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidr) 
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_route.id
}



resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidr) 
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_route[count.index].id
}
