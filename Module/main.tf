//define madule
data "aws_subnets" "default_subnets" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"
  name = "ec2_cluster"
  ami = "ami-05803413c51f242b7"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnets.default_subnets.ids[0]

   tags = {
    Name = "ec2_cluster"
    environment = "development"

  }

}