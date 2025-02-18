resource "aws_security_group" "UbuntuSG" {
    description = "Allow inbound and outbound traffic"

    ingress {
        from_port         = var.ingressfrom
        to_port           = var.ingressto
        protocol          = "tcp"
        cidr_blocks       = ["0.0.0.0/0"]
        }
    
    egress {
        from_port         = 0
        to_port           = 0
        protocol          = "-1"
        cidr_blocks       = ["0.0.0.0/0"]
            }
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "UbuntuKP" {
    key_name   = "mykey"
    public_key = var.key_pair

    provisioner "local-exec" { # Download "myKey.pem" locally!!
        command = "echo '${tls_private_key.pk.private_key_pem}' > ~/mykey.pem"
  }
}
