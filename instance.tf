# instance.tf
# Launch instances across multiple AZs

resource "aws_instance" "my_ec2" {

instance_type = "t2.micro"
ami= "ami-0080e4c5bc078760e"
count = 3
availability_zone = "${element(var.azs, count.index)}"
tags{

Name= "my_ec2-${count.index}"

}

}
