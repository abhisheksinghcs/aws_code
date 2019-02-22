# snstopic.tf

# Define the autoscaling group
resource "aws_sns_topic" "sample_cpu_sns" {
  name         = "sample_cpu_sns"
  display_name = "Sample Autoscaling SNS Topic"
}

# Attach to autoscaling group

resource "aws_autoscaling_notification" "sample_autoscaling_notification" {
  group_names = ["${aws_autoscaling_group.sample_autoscaling_group.name}"]
  topic_arn   = "${aws_sns_topic.sample_cpu_sns.arn}"

  # A list of Notification Types that trigger notifications. 

  notifications = ["autoscaling:EC2_INSTANCE_LAUNCH", "autoscaling:EC2_INSTANCE_TERMINATE", "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"]
}
