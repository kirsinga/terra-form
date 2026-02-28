//define madule
module "ec2_cluster" {
  source = "terraform-aws-modules/terraform-aws-ec2-instance.git"
  vpc_cidr = ""
  name = "ec2_cluster"
  ami = "ami-0f40c8f97004632f9"
  instance_type = "t2.micro"
  subnet_id = "subnet-05e41af1b0abba5d"

   tags = {
    Name = "ec2_cluster"
    environment = "development"

  }

}