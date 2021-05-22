# module "vpc" {
#     source = "../vpc"
   
# }

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Main"
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}