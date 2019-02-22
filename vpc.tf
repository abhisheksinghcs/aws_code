# vpc.tf

# Define the vpc

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
}

# Define the subnets

resource "aws_subnet" "main_vpc_subnet_1" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "main_vpc_subnet_2" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"
}

# Create internet gateway

resource "aws_internet_gateway" "main_vpc_internet_gateway" {
  vpc_id = "${aws_vpc.main_vpc.id}"
}

# Define the route table for the vpc

resource "aws_route_table" "main_vpc_route_table" {
  vpc_id = "${aws_vpc.main_vpc.id}"
}

# Define routes

resource "aws_route" "main_vpc_route" {
  route_table_id         = "${aws_route_table.main_vpc_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main_vpc_internet_gateway.id}"
}

resource "aws_route_table_association" "main_vpc_subnet_1_association" {
  route_table_id = "${aws_route_table.main_vpc_route_table.id}"
  subnet_id      = "${aws_subnet.main_vpc_subnet_1.id}"
}

resource "aws_route_table_association" "main_vpc_subnet_2_association" {
  route_table_id = "${aws_route_table.main_vpc_route_table.id}"
  subnet_id      = "${aws_subnet.main_vpc_subnet_2.id}"
}
