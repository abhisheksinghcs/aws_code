# iam.tf

# Define the role and policy to allow packer access 
# to create the builds

# Section 1. Create a role and also the policy

resource "aws_iam_policy" "packer_policy" {
  name = "packer_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
      "Effect": "Allow",
      "Action" : ["ec2:AttachVolume","ec2:AuthorizeSecurityGroupIngress","ec2:CopyImage","ec2:CreateImage","ec2:CreateKeypair","ec2:CreateSecurityGroup","ec2:CreateSnapshot","ec2:CreateTags","ec2:CreateVolume","ec2:DeleteKeyPair","ec2:DeleteSecurityGroup","ec2:DeleteSnapshot","ec2:DeleteVolume","ec2:DeregisterImage","ec2:DescribeImageAttribute","ec2:DescribeImages","ec2:DescribeInstances","ec2:DescribeInstanceStatus","ec2:DescribeRegions","ec2:DescribeSecurityGroups","ec2:DescribeSnapshots","ec2:DescribeSubnets","ec2:DescribeTags","ec2:DescribeVolumes","ec2:DetachVolume","ec2:GetPasswordData","ec2:ModifyImageAttribute","ec2:ModifyInstanceAttribute","ec2:ModifySnapshotAttribute","ec2:RegisterImage","ec2:RunInstances","ec2:StopInstances","ec2:TerminateInstances"],
      "Resource" : "*"
  }]
}
	POLICY
}

resource "aws_iam_role" "packer_role" {
  name = "packer_role"

  assume_role_policy = <<POLICY
{
	"Statement": [
	{
		"Action":"sts:AssumeRole",
		"Principal": {
			"Service": "ec2.amazonaws.com"
		},
		"Effect": "Allow",
		"Sid": ""
	}
	]
}
	POLICY
}

resource "aws_iam_role_policy_attachment" "packer_attachment" {
  role       = "${aws_iam_role.packer_role.name}"
  policy_arn = "${aws_iam_policy.packer_policy.arn}"
}
