# instance.tf

# Define EC2 on the public subnet

resource "aws_instance" "public_ec2" {

# Add EC2 to public subnet
subnet_id = "${aws_subnet.main_public_1.id}"
ami = "${lookup(var.AMIs,var.AWS_REGION)}"
instance_type = "t2.micro"
vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

key_name = "${aws_key_pair.my_key_pair.key_name}"

tags {
Name = "Public-EC2"
Type = "test"
}

}
