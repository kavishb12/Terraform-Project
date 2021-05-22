resource "aws_instance" "nexus" {
  ami           = data.aws_ami.amazonlinux.id
  instance_type = "t2.micro"

  tags = {
    Name = "nexus"
  }

  subnet_id =   var.subnet_id
  
  vpc_security_group_ids = [var.sg_id]

  key_name = "terraform-key"

provisioner "remote-exec" {
    inline = [
      "sudo yum install java-1.8.0-openjdk.x86_64 -y",
      "sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz",
      "sudo tar -xvf nexus.tar.gz",
      "sudo mv nexus-3* nexus",
      "sudo cp nexus/bin/nexus /etc/init.d/nexus",
      "sudo service nexus start"    
    ]

    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("../../../terraform-key.pem")
    host     = "${self.public_ip}"
  }

  }
}

resource "aws_eip" "nexus" {
  instance = aws_instance.nexus.id
  vpc      = true
}