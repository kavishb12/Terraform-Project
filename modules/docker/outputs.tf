# output "docker_eip_addr" {
#   value = aws_eip.docker.address
# }

output "docker_ip_addr" {
  value = aws_instance.docker.public_ip
}