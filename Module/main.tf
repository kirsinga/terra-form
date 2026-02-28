//define madule
module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"
  name = "ec2_cluster"
  ami = "ami-05692172625678b4e"
  instance_type = "t2.micro"
  subnet_id = "subnet-05e41af1b0abba5d"

   tags = {
    Name = "ec2_cluster"
    environment = "development"

  }

}