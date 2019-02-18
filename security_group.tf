# security_group.tf

# Define the inbound SSH and outbound all 

resource "aws_security_group" "allow_ssh" {

vpc_id = "${aws_vpc.main.id}"
name = "allow_ssh"
description = "Security Group to allow all incoming  SSH traffic and outgoing traffic"

ingress {
from_port = "0"
to_port = "22"
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = "0"
to_port = "0"
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

tags {
Name = "allow-ssh"
Type = "test"
}
}
