resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr["${element(var.vpc_name, count.index)}"]}"
  enable_dns_hostnames = false
  enable_dns_support   = true
  instance_tenancy     = "default"
  count = "${length(var.vpc_name)}"

  tags {
    "Name" = "${element(var.vpc_name, count.index)}"
  }
}

resource "aws_subnet" "prod-subnet-public" {

  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.prod-subnet_cidr-public["${element(var.prod-subnet_name-public, count.index)}"]}"
  availability_zone       = "${var.prod-subnet_az-public["${element(var.prod-subnet_name-public, count.index)}"]}"
  map_public_ip_on_launch = false
  count = "${length(var.prod-subnet_name-public)}"

  tags {
    "Name" = "${element(var.prod-subnet_name-public, count.index)}"
  }
}

resource "aws_subnet" "prod-subnet-internal" {

  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.prod-subnet_cidr-internal["${element(var.prod-subnet_name-internal, count.index)}"]}"
  availability_zone       = "${var.prod-subnet_az-internal["${element(var.prod-subnet_name-internal, count.index)}"]}"
  map_public_ip_on_launch = false
  count = "${length(var.prod-subnet_name-internal)}"

  tags {
    "Name" = "${element(var.prod-subnet_name-internal, count.index)}"
  }
}

resource "aws_internet_gateway" "igw_name" {
  vpc_id = "${aws_vpc.vpc.id}"
  count = "${length(var.igw_name)}"
  tags {
    "Name" = "${element(var.igw_name, count.index)}"
  }
}

resource "aws_eip" "nat" {
  count = "${length(var.prod-subnet_name-public)}"
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  subnet_id = "${aws_subnet.prod-subnet-public.*.id[count.index]}"
  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  count = "${length(var.prod-subnet_name-public)}"
}
# ROUTE TABLE
resource "aws_route_table" "igw" {
  vpc_id     = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw_name.id}"
  }
  tags {
    "Name" = "igw"
  }
}

resource "aws_route_table" "natgw" {
  vpc_id = "${aws_vpc.vpc.id}"
//  count = "${length(var.prod-subnet_name-public)}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.*.id[count.index]}"
  }
  tags {
    Name = "natgw"
  }
}

# ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "prod-subnet-public" {
  subnet_id = "${aws_subnet.prod-subnet-public.*.id[count.index]}"
  route_table_id = "${aws_route_table.igw.id}"
  count = "${length(var.prod-subnet_name-public)}"
}

resource "aws_route_table_association" "prod-subnet-internal" {
  subnet_id = "${aws_subnet.prod-subnet-internal.*.id[count.index]}"
  route_table_id = "${aws_route_table.natgw.id}"
  count = "${length(var.prod-subnet_name-internal)}"
}