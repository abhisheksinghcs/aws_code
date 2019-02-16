# natgw.tf

resource "aws_eip" "nat_gateway_ip" {

	vpc = "true"
}

# Create NAT Gateway
resource "aws_nat_gateway" "main_nat_gateway" {
	allocation_id = "${aws_eip.nat_gateway_ip.id}"
	subnet_id = "${aws_subnet.main_public_1.id}"
depends_on = ["aws_internet_gateway.main_gateway"]
tags {

Name = "Main-NAT-Gateway"
Type = "Test"
}
}

# Now set up a route table and attach that to NAT Gateway
# Later we will also attach the routes to private subnets

resource "aws_route_table" "nat_gateway_route_table" {

vpc_id = "${aws_vpc.main.id}"
route = {

	cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.main_nat_gateway.id}"
}
tags {
Name = "NAT-Gateway-Route-Table"
Type = "Test"
}


}


# Route associations private

resource "aws_route_table_association" "main_private_1"
 {
	route_table_id = "${aws_route_table.nat_gateway_route_table.id}"
	subnet_id = "${aws_subnet.main_private_1.id}"

}

resource "aws_route_table_association" "main_private_2"
 {
	route_table_id = "${aws_route_table.nat_gateway_route_table.id}"
	subnet_id = "${aws_subnet.main_private_2.id}"

}

resource "aws_route_table_association" "main_private_3"
 {
	route_table_id = "${aws_route_table.nat_gateway_route_table.id}"
	subnet_id = "${aws_subnet.main_private_3.id}"

}
