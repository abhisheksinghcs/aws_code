# scaling.tf

# Define the classic load balancers and Autoscaling

# Section 1. Describe the launch config for different type of 
# servers

# 1.A  Get latest image from ubuntu

data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# 1.B Define Launch Config for Web Servers 

resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_launch_configuration" "web_launch_config" {
  name              = "web_launch_config"
  image_id          = "${data.aws_ami.ubuntu.id}"
  instance_type     = "t2.micro"
  key_name          = "${aws_key_pair.my_key.key_name}"
  placement_tenancy = "default"

  lifecycle {
    create_before_destroy = "true"
  }
}

# 1.C Define the Auto Scaling Group

resource "aws_autoscaling_group" "web_scaling_group" {
  name                      = "web_scaling_group"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = "true"
  launch_configuration      = "${aws_launch_configuration.web_launch_config.name}"
  default_cooldown          = 300
  vpc_zone_identifier       = ["${aws_subnet.public_subnet_1.id}", "${aws_subnet.public_subnet_2.id}"]
}

# 1. D Define Auto Scaling Policy

resource "aws_autoscaling_policy" "web_scaling_policy" {
  name                   = "web_scaling_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.web_scaling_group.name}"
}

# Section 2. Define a classic load balancer

resource "aws_elb" "web_elb" {
  name    = "web-elb"
  subnets = ["${aws_subnet.public_subnet_1.id}", "${aws_subnet.public_subnet_2.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = "true"
  idle_timeout                = 60
  connection_draining         = "true"
  connection_draining_timeout = 300
}

# 2.B attach ELB to auto scaling group

resource "aws_autoscaling_attachment" "attach_web_elb" {
  autoscaling_group_name = "${aws_autoscaling_group.web_scaling_group.name}"
  elb                    = "${aws_elb.web_elb.id}"
}
