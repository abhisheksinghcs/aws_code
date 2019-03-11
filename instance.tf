# instance.tf

# Section 1. Define the SSH keys

# APIs EXPORTED PATH_TO_PUBLIC_KEY

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

# Section 2. Define AWS instance

# APIs Exported: AMIs, INSTANCE_TYPE, PUBLIC, ROLE (DEPENDING WEB OR NOT) 

resource "aws_instance" "my_instance" {
  ami                    = "${var.AMI}"
  instance_type          = "${var.INSTANCE_TYPE}"
  subnet_id              = "${var.PUBLIC == "true"? "${aws_subnet.public_subnet_1.id}": "${aws_subnet.private_subnet_1.id}"}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}
