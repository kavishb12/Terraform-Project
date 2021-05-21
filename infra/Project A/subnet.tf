# module "vpc" {
#     source = "../vpc"
   
# }

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, 1)

  tags = {
    Name = "Main"
  }
}