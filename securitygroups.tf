# securitygroups.tf

# Define the security groups related to this autoscaling group

resource "aws_security_group" "allow_ssh_security_group" {
  name        = "allow_ssh"
  vpc_id      = "${aws_vpc.main_vpc.id}"
  description = "Allow inbound ssh connection"
}

resource "aws_security_group_rule" "allow_ssh_rule" {
  security_group_id = "${aws_security_group.allow_ssh_security_group.id}"
  type              = "ingress"
  depends_on        = ["aws_security_group.allow_ssh_security_group"]
  from_port         = 0
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
