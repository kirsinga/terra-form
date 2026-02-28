output "vpc_id" {
  value = aws_vpc.aws_vpc_levelup.id
}

output "vpc_cidr" {
  value = aws_vpc.aws_vpc_levelup.cidr_block
}
