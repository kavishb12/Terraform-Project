resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amazonlinux.id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }

  subnet_id =   var.subnet_id
  
  security_groups = [var.sg_id]

provisioner "remote-exec" {
    inline = [
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade",
      "sudo systemctl daemon-reload",
      "sudo systemctl start jenkins"
    ]
  }
}