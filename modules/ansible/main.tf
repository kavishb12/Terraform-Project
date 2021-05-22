# data "aws_subnet" "selected" {
#   filter {
#     name   = "tag:Name"
#     values = ["Main"]
#   }
# }

resource "aws_instance" "ansible" {
  ami           = data.aws_ami.amazonlinux.id
  instance_type = "t2.micro"

  tags = {
    Name = "ansible"
  }

  subnet_id =   var.subnet_id
  
  vpc_security_group_ids = [var.sg_id]

  key_name = "terraform-key"
  
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install ansible2 -y"
    ]

    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("../../../terraform-key.pem")
    host     = "${self.public_ip}"
  }

  }
}

resource "aws_eip" "ansible" {
  instance = aws_instance.ansible.id
  vpc      = true
}