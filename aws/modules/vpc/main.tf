resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  instance_tenancy                 = var.instance_tenancy
  tags                             = var.tags
}

################
# Public subnet
################
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  cidr_block        = each.value.cidr
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value.az
  tags              = each.value.tags
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  cidr_block              = each.value.cidr
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.map_public_ip
  tags                    = each.value.tags
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.igw_tags
}

resource "aws_eip" "nat" {
  for_each = var.public_subnets
  vpc      = true
}

resource "aws_nat_gateway" "nat" {
  for_each      = var.public_subnets
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id
}

resource "aws_route_table" "igw" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "igw"
  }
}

resource "aws_route_table" "natgw" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.public_subnets
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "natgw"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = var.public_subnets
  route_table_id = aws_route_table.igw.id
  subnet_id      = aws_subnet.public[each.key].id
}
