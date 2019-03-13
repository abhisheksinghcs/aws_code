# logging.tf
# Enable logging on instances and
# store logs in a S3 bucket

# Section 1. Create S3 bucket used for storing logs

resource "aws_s3_bucket" "logging_bucket" {
  bucket        = "logging-bucket-08710"
  acl           = "private"
  force_destroy = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::logging-bucket-08710"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::logging-bucket-08710/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY

  tags {
    Name = "logging-bucket"
  }
}

# Section 2. Create cloudtrail

resource "aws_cloudtrail" "web_trail" {
  name                          = "web_trail"
  s3_bucket_name                = "${aws_s3_bucket.logging_bucket.id}"
  include_global_service_events = "true"

  tags {
    Name = "web-cloud-trail"
  }
}
