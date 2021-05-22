resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amazonlinux.id
  instance_type = "t2.micro"

  tags = {
    Name = "jenkins"
  }

  subnet_id =   var.subnet_id
  
  vpc_security_group_ids = [var.sg_id]

  key_name = "terraform-key"

provisioner "remote-exec" {
    inline = [
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade",
      "sudo yum install jenkins -y && sudo amazon-linux-extras install java-openjdk11 -y",
      "sudo systemctl daemon-reload",
      "sudo service jenkins start"
    ]

    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("../../../terraform-key.pem")
    host     = "${self.public_ip}"
  }

  }
}

resource "aws_eip" "jenkins" {
  instance = aws_instance.jenkins.id
  vpc      = true
}