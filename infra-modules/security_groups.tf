# security_groups.tf

# Define the security groups tied to main vpc and expose them via APIs

resource "aws_security_group" "allow_ssh" {
  name   = "allow_ssh"
  vpc_id = "${aws_vpc.main_vpc.id}"

  ingress {
    from_port   = 22
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
    name = "main-vpc-allow-ssh"
  }
}
