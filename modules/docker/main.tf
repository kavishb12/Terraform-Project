resource "aws_instance" "docker" {
  ami           = data.aws_ami.amazonlinux.id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }

  subnet_id =   var.subnet_id
  
  security_groups = [var.sg_id]
  
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install docker",
      "sudo service docker start"
    ]
  }
}