module "ansible" {
    source = "../../modules/ansible"
    subnet_id = aws_subnet.main.id
    sg_id = aws_security_group.allow_tls.id
}

module "docker" {
    source = "../../modules/docker"
    subnet_id = aws_subnet.main.id
    sg_id = aws_security_group.allow_tls.id

}

module "jenkins" {
    source = "../../modules/jenkins"
    subnet_id = aws_subnet.main.id
    sg_id = aws_security_group.allow_tls.id

}

module "nexus" {
    source = "../../modules/nexus"
    subnet_id = aws_subnet.main.id
    sg_id = aws_security_group.allow_tls.id

}