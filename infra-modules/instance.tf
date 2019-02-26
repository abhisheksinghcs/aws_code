# instance.tf

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key"
  public_key = "${var.PATH_TO_PUBLIC_KEY}"
}

# Creates an EC2 instance depending on the criteria supplied

resource "aws_instance" "create_instance" {
  instance_type          = "${var.INSTANCE_TYPE}"
  ami                    = "${lookup (var.AMIS, var.ENVIRONMENT)}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  key_name               = "${aws_key_pair.my_key_pair.key_name}"
  subnet_id              = "${var.ENVIRONMENT == "prod"? "${aws_subnet.main_vpc_public_subnet_1.id}": var.ENVIRONMENT == "staging"?"${aws_subnet.main_vpc_public_subnet_1.id}":"${aws_subnet.main_vpc_public_subnet_2.id}" }"
}
