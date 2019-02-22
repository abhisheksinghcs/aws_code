# cloudwatchalarms.tf

resource "aws_cloudwatch_metric_alarm" "sample_cloudwatch_alarm" {
  alarm_name          = "sample_cloudwatch_alarm"
  alarm_description   = "This alarm to start trigger the autoscaling policy"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  metric_name         = "CPUUtilization"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.sample_autoscaling_group.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.sample_autoscaling_policy.arn}"]
}
