# routes.tf

# Define the route table and associated route for each subnet

resource "aws_route_table" "main_vpc_route_table" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    name = "main-vpc-route-table"
  }
}

resource "aws_route" "main_vpc_internet_access" {
  route_table_id         = "${aws_route_table.main_vpc_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main_vpc_internet_gateway.id}"
  depends_on             = ["aws_route_table.main_vpc_route_table"]
}

# Associate subnets to the route table for public access

resource "aws_route_table_association" "main_vpc_public_subnet_1_internet_access" {
  subnet_id      = "${aws_subnet.main_vpc_public_subnet_1.id}"
  route_table_id = "${aws_route_table.main_vpc_route_table.id}"
}

resource "aws_route_table_association" "main_vpc_public_subnet_2_internet_access" {
  subnet_id      = "${aws_subnet.main_vpc_public_subnet_2.id}"
  route_table_id = "${aws_route_table.main_vpc_route_table.id}"
}
