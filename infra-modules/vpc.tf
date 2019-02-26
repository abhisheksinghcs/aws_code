# vpc.tf

# Define the VPCs, Subnets, and Routes

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    name = "main-vpc"
  }
}

resource "aws_subnet" "main_vpc_public_subnet_1" {
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags {
    name = "main-vpc-public-subnet-1"
  }
}

resource "aws_subnet" "main_vpc_public_subnet_2" {
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags {
    name = "main-vpc-public-subnet-2"
  }
}

# Define private subnets

resource "aws_subnet" "main_vpc_private_subnet_1" {
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags {
    name = "main-vpc-private-subnet-1"
  }
}

resource "aws_subnet" "main_vpc_private_subnet_2" {
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1d"

  tags {
    name = "main-vpc-private-subnet-2"
  }
}

resource "aws_internet_gateway" "main_vpc_internet_gateway" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    name = "main-vpc-internet-gateway"
  }
}
