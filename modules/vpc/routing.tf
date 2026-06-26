
############################################
# PUBLIC ROUTE TABLE
############################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-public-rt"
  })
}

############################################
# PRIVATE ROUTE TABLES (dynamic NAT-aware)
############################################
resource "aws_route_table" "private" {
  count  = local.nat_count
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-private-rt-${count.index + 1}"
  })
}

############################################
# PUBLIC ASSOCIATION
############################################
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

############################################
# PRIVATE ASSOCIATION (SAFE MAPPING)
############################################
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private[
    count.index % local.nat_count
  ].id
}
