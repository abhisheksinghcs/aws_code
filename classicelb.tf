# classicelb.tf

# Define the load balancer to monitor the autoscaling group

resource "aws_elb" "sample_elb" {
  name = "sample-elb"

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  security_groups = ["${aws_security_group.allow_ssh_security_group.id}"]
  subnets         = ["${aws_subnet.main_vpc_subnet_1.id}", "${aws_subnet.main_vpc_subnet_2.id}"]

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}

# Attach the autoscaling group to the elb

resource "aws_elb_attachment" "sample_elb_attachment" {
  elb      = "${aws_elb.sample_elb.id}"
  instance = "${aws_autoscaling_group.sample_autoscaling_group.id}"
}
