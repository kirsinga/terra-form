
data "aws_key_pair" "levelup_key" {
  key_name = var.KEY_PAIR_NAME
}

resource "aws_instance" "MyFirstInstnace" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.levelup_key.key_name
  user_data     = file("installapache.sh")

  tags = {
    Name = "custom_instance"
  }
}
output "public_ip" {
  value = aws_instance.MyFirstInstnace.public_ip
}