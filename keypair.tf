# keypairs.tf

resource "aws_key_pair" "my_key_pair" {

key_name = "my_key_pair"
public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"

}
