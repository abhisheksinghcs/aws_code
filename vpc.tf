# Internet VPC

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "main"
    Type = "test"
  }
}

# Subnets

resource "aws_subnet" "main_public_1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags {
    Name = "main-public-1"
    Type = "Test"
  }
}

resource "aws_subnet" "main_public_2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags {
    Name = "main-public-2"
    Type = "test"
  }
}

resource "aws_subnet" "main_public_3" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags {
    Name = "main-public-3"
    Type = "test"
  }
}

# Private subnets

resource "aws_subnet" "main_private_1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1d"

  tags {
    Name = "main-private-1"
    Type = "test"
  }
}

resource "aws_subnet" "main_private_2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1e"

  tags {
    Name = "main-private-2"
    Type = "test"
  }
}

resource "aws_subnet" "main_private_3" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1f"

  tags {
    Name = "main-private-3"
    Type = "test"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main_gateway" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main-public-gateway"
    Type = "test"
  }
}

# Route Tables

resource "aws_route_table" "main_public_route_table" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main_gateway.id}"
  }

  tags {
    Name = "main-public-route-table"
    Type = "Test"
  }
}

resource "aws_route_table_association" "main_public_1_route_association" {
  subnet_id      = "${aws_subnet.main_public_1.id}"
  route_table_id = "${aws_route_table.main_public_route_table.id}"
}

resource "aws_route_table_association" "main_public_2_route_association" {
  subnet_id      = "${aws_subnet.main_public_2.id}"
  route_table_id = "${aws_route_table.main_public_route_table.id}"
}

resource "aws_route_table_association" "main_public_3_route_association" {
  subnet_id      = "${aws_subnet.main_public_3.id}"
  route_table_id = "${aws_route_table.main_public_route_table.id}"
}
