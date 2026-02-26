
resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "MyFirstInstnace" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name

  tags = {
    Name = "custom_instance"
  }
}
resource "aws_volume_attachment" "ebs_attachement" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.levelup_volume.id
  instance_id = aws_instance.MyFirstInstnace.id

}
resource "aws_ebs_volume" "levelup_volume" {
  availability_zone = aws_instance.MyFirstInstnace.availability_zone
  size              = 50
  tags = {
    Name = "secondary_volume"
   }
}