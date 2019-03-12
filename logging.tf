# logging.tf
# Enable logging on instances and
# store logs in a S3 bucket

# Section 1. Create S3 bucket used for storing logs

resource "aws_s3_bucket" "logging_bucket" {
  bucket = "logging-bucket-08710"
  acl    = "private"

  tags {
    Name = "logging-bucket"
  }
}
