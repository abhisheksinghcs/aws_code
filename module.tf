module "consul" {
	source = "github.com/wardviaene/terraform-consul-module.git"
	key_name = "${aws_key_pair.my_key.key_name}"
	key_path = "${var.PATH_TO_PRIVATE_KEY}"
	region = "${var.AWS_REGION}"
	vpc_id = "${aws_default_vpc.default.id}"
subnets {
	"0"= "${aws_default_subnet.default_az1.id}"
	"1"= "${aws_default_subnet.default_az2.id}"
	"2"= "${aws_default_subnet.default_az3.id}"

	}

 }

output "consul_output" {
value = "${module.consul.server_address}"
}
