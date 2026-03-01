//aws provider
provider "aws" {
  
  region = var.subnet1_az
}
module "myvpc" {
  source="./module/custom_vpc"
}
//resource key pair
resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.public_key_path)
}   

//EC2 instance resource
resource "aws_instance" "MyFirstInstnace" { 
    ami           = var.ami_id
    instance_type = var.instance_type
    key_name      = aws_key_pair.levelup_key.key_name
    vpc_security_group_ids = ["${module.network.security_group_id}"]
    subnet_id = module.network.module_subnet1.id
 
    
    tags = {
        Name = "custom_instance"
    }
    
   

}