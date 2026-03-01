//output of public ip of instance created in VPC module
output "public_ip" {
  value = aws_instance.MyFirstInstnace.public_ip
}