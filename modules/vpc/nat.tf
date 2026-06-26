
############################################
# Elastic IPs (dynamic)
############################################
resource "aws_eip" "nat" {
  count  = local.nat_count
  domain = "vpc"

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-eip-${count.index + 1}"
  })
}

############################################
# NAT Gateways (dynamic)
############################################
resource "aws_nat_gateway" "nat" {
  count = local.nat_count

  allocation_id = aws_eip.nat[count.index].id

  ############################################
  # IMPORTANT DESIGN RULE:
  # Spread NATs across public subnets safely
  ############################################
  subnet_id = element(
    aws_subnet.public[*].id,
    count.index % length(aws_subnet.public)
  )

  depends_on = [aws_internet_gateway.igw]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nat-${count.index + 1}"
  })
}
