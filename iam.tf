# iam.tf

# Create IAM roles for instance_profiles so logs 
# can be stored in a S3 bucket

# Section 1. Create the iam role

data "aws_iam_policy_document" "role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals = {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "logging_role" {
  name = "logging_role"

  assume_role_policy = "${data.aws_iam_policy_document.role_policy.json}"
}

# Section 2. Create the s3 policy

data "aws_iam_policy_document" "s3_policy_document" {
  statement {
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "logging_policy" {
  name        = "logging_policy"
  description = "A policy to store logs"
  policy      = "${data.aws_iam_policy_document.s3_policy_document.json}"
}

# Section 3. Attach policy

resource "aws_iam_role_policy_attachment" "logging_role_attachment" {
  role       = "${aws_iam_role.logging_role.name}"
  policy_arn = "${aws_iam_policy.logging_policy.arn}"
}
