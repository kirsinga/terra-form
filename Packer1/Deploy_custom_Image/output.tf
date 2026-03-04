//out put vpc id and cidr block
output "vpc_id" {
  value = aws_vpc.aws_vpc_levelup.id
}
//out put for sublic sunet id 
output "subnet1_id" {
  value = aws_subnet.levelup_subnet1.id
}
//output for secuirty group id 
output "security_group_id" {
  value = aws_security_group.levelup_sg.id
}