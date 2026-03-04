
//module to create an Ec2 instance using the AMI created by packer
module "develop_vpc" {
  
  source = "../Deploy_custom_Image/vpc.tf"
  ENVIRONMENT = var.ENVIRONMENT
  AWS_REGION = var.AWS_REGION
}
// AWS key pair resource to create a key pair for SSH access to the EC2 instance
resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}   
// AWS instance resource to create an EC2 instance using the specified AMI and instance type
resource "aws_instance" "MyFirstInstnace" {
  ami           = var.AMIS
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name
  availability_zone = var.AWS_REGION



  

  tags = {
    Name = "custom_instance"
  }

 vpc_security_group_ids = [module.develop_vpc.security_group_id]
 subnet_id = module.develop_vpc.subnet_id

}

//AWS security group resource to create a security group that allows SSH access to the EC2 instance
resource "aws_security_group" "levelup_allow_ssh" {
  name        = "levelup_allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.develop_vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
        Name = "levelup_allow_ssh"
    }
}
