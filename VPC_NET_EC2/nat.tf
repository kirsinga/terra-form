//Define external ip
resource "aws_eip" "levelup_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "levelup_nat_eip"
  }
}
resource "aws_nat_gateway" "levelup_nat_gateway" {
  allocation_id = aws_eip.levelup_nat_eip.id
  subnet_id     = aws_subnet.levelup_subnet1.id
  depends_on = [ aws_internet_gateway.levelup_igw ]

}  

resource "aws_route_table" "levelup_private_rt" {
  vpc_id = aws_vpc.vpc_levelup.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.levelup_nat_gateway.id
  }

  tags = {
    Name = "levelup_private_rt"
  }
}

resource "aws_route_table_association" "levelup_private_rt_assoc1" {
  subnet_id      = aws_subnet.levelup_private_subnet1.id
  route_table_id = aws_route_table.levelup_private_rt.id
}
resource "aws_route_table_association" "levelup_private_rt_assoc2" {
  subnet_id      = aws_subnet.levelup_private_subnet2.id
  route_table_id = aws_route_table.levelup_private_rt.id
}
resource "aws_route_table_association" "levelup_private_rt_assoc3" {
  subnet_id      = aws_subnet.levelup_private_subnet3.id
  route_table_id = aws_route_table.levelup_private_rt.id
}