resource "aws_instance" "nexus" {
  ami           = data.aws_ami.amazonlinux.id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }

  subnet_id =   var.subnet_id
  
  security_groups = [var.sg_id]

provisioner "remote-exec" {
    inline = [
      "sudo yum install java-1.8.0-openjdk.x86_64 -y",
      "sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz",
      "sudo tar -xvf nexus.tar.gz",
      "sudo mv nexus-3* nexus",
      "sudo systemctl start nexus"    
    ]
  }
}