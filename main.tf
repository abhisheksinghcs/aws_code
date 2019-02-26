# main.tf

# Create instances using modules

module "staging"{
source = "./infra-modules"
ENVIRONMENT = "prod"
INSTANCE_TYPE = "t2.micro"
PATH_TO_PUBLIC_KEY = "${file("mykey.pub")}"
}

output "stage_public_ip" {
value = "${module.staging.instance_public_ip}"
}
