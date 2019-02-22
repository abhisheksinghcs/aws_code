#autoscalinglaunchconfig.tf

# Define the sample configuration that will be used to spin the systems
resource "aws_launch_configuration" "sample_launch_configuration" {
  name            = "sample_launch_configuration"
  image_id        = "ami-04b8c2001b0bf0c27"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.my_key.key_name}"
  security_groups = ["${aws_security_group.allow_ssh_security_group.id}"]
}

# Define the auto scaling group that will spin up systems 
# based on the auto scaling policy

resource "aws_autoscaling_group" "sample_autoscaling_group" {
  name                 = "sample_autoscaling_group"
  launch_configuration = "${aws_launch_configuration.sample_launch_configuration.name}"
  vpc_zone_identifier  = ["${aws_subnet.main_vpc_subnet_1.id}", "${aws_subnet.main_vpc_subnet_2.id}"]

  max_size                  = 2
  min_size                  = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = "true"
}
