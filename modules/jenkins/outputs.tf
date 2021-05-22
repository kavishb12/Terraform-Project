# output "jenkins_eip_addr" {
#   value = aws_eip.jenkins.address
# }

output "jenkins_ip_addr" {
  value = aws_instance.jenkins.public_ip
}