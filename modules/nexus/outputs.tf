# output "nexus_eip_addr" {
#   value = aws_eip.nexus.address
# }

output "nexus_ip_addr" {
  value = aws_instance.nexus.public_ip
}