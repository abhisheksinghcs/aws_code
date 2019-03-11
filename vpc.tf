#vpc.tf
###########################################################
# Define the VPCs, Subnets, Internet Gateway, NAT Gateway,
# Route tables, routes, configure peering
###########################################################

# Section 1. Define VPC

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "public-vpc"
  }
}

# Section 2. Define subnets

## Section 2.a. Public Subnets

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags {
    Name = "main-vpc-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags {
    Name = "main-vpc-public-subnet-2"
  }
}

## Section 2.b. Private Subnets

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = "${aws_vpc.main_vpc.id}"
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags {
    Name = "main-vpc-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = "${aws_vpc.main_vpc.id}"
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1d"

  tags {
    Name = "main-vpc-private-subnet-2"
  }
}

# Section 3. Define internet gateway

resource "aws_internet_gateway" "main_vpc_internet_gateway" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
    Name = "main-vpc-internet-gateway"
  }
}

# Section 4. Define route table and routes

resource "aws_route_table" "main_vpc_route_table" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    Name = "main-vpc-route-table"
  }
}

resource "aws_route" "main_vpc_public_route" {
  route_table_id         = "${aws_route_table.main_vpc_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main_vpc_internet_gateway.id}"
  depends_on             = ["aws_route_table.main_vpc_route_table"]
}

resource "aws_route_table_association" "associate_public_routes" {
  subnet_id      = "${aws_subnet.public_subnet_1.id}"
  route_table_id = "${aws_route_table.main_vpc_route_table.id}"
}

resource "aws_route_table_association" "main_vpc_public_route_2" {
  route_table_id = "${aws_route_table.main_vpc_route_table.id}"
  subnet_id      = "${aws_subnet.public_subnet_2.id}"
}

# Section 5. Define security groups

resource "aws_security_group" "allow_ssh" {
  name        = "allow_all"
  description = "Allow all incoming SSH traffic"
  vpc_id      = "${aws_vpc.main_vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow-ssh-sg"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow-http"
  description = "Allow incoming traffic to http servers"
  vpc_id      = "${aws_vpc.main_vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow-http-inbound"
  }
}
