variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "INSTANCE_TYPE" {
  description = "type of EC2 instance"
}

variable "ENVIRONMENT" {
  description = "Select the type of environment for lanching instance : prod, dev, staging"
  default     = "staging"
}

variable "AMIS" {
  type = "map"

  default = {
    "prod"    = "ami-0e20aa616a87117f0"
    "dev"     = "ami-0565af6e282977273"
    "staging" = "ami-0565af6e282977273"
  }
}

variable "SUBNET_ID" {
  type = "map"

  default = {
    "dev"     = "${}"
    "staging" = "${}"
    "prod"    = "${aws_subnet.main_vpc_public_subnet_1.id}"
  }
}
