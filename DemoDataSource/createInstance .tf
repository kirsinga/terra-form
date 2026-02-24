
data "aws_availability_zones" "available" {
  
}
data "aws_ami" "latest" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Amazon
}
resource "aws_instance" "MyFirstInstnace" {
  ami           = data.aws_ami.latest.id
  instance_type = "t2.micro"
  availability_zone = data.aws_availability_zones.available.names[1]
 
  tags = {
    Name = "custom_instance"
  }

   
}