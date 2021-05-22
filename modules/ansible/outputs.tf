# output "ansible_eip_addr" {
#   value = aws_eip.ansible.public_ip
# }

output "ansible_ip_addr" {
  value = aws_instance.ansible.public_ip
}