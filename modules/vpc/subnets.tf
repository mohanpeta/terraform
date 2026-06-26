
# PUBLIC SUBNETS
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-public-${count.index + 1}"

    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${local.name_prefix}" = "shared"
  })
}

# PRIVATE SUBNETS
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-private-${count.index + 1}"

    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${local.name_prefix}" = "shared"
  })
}
