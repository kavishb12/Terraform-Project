resource "aws_instance" "docker" {
  ami           = data.aws_ami.amazonlinux.id
  instance_type = "t2.micro"

  tags = {
    Name = "docker"
  }

  subnet_id =   var.subnet_id
  
  vpc_security_group_ids = [var.sg_id]

  key_name = "terraform-key"
  
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start"
    ]
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("../../../terraform-key.pem")
    host     = "${self.public_ip}"
  }

  }
}

resource "aws_eip" "docker" {
  instance = aws_instance.docker.id
  vpc      = true
}