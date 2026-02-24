
resource "aws_instance" "MyFirstInstnace" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = data.aws_availability_zones.available.names[1]

  provisioner "local-exec" {
      command = "echo ${aws_instance.MyFirstInstnace.public_ip} > instance_ip.txt" 
  tags = {
    Name = "custom_instance"
    
    }
  output "instance_ip" {
    value = aws_instance.MyFirstInstnace.public_ip
  }

   
}