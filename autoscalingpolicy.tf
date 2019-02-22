# autoscalingpolicy.tf

# Define the policy that is used to increase and decrease the number of running EC2 instances in the group dynamically to meet changing conditions

resource "aws_autoscaling_policy" "sample_autoscaling_policy" {
  name                   = "sample_autoscaling_policy"
  autoscaling_group_name = "${aws_autoscaling_group.sample_autoscaling_group.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}
