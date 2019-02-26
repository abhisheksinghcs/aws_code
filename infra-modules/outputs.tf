# outputs.tf

# Outputs from module

output "instance_public_ip" {
  value = "${aws_instance.create_instance.public_ip}"
}
