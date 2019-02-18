variable "AWS_SECRET_KEY" {}

variable "AWS_ACCESS_KEY" {}



variable "AWS_REGION" {
default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
	default = "mykey"

}


variable "PATH_TO_PUBLIC_KEY" { 

default = "mykey.pub"

}

variable "azs" {
type = "list"
default = ["us-east-1a","us-east-1b","us-east-1c"]
}
