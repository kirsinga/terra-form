//creat all variable in module main.tf  in module folder file 
variable "subnet1_az" {
    description = "The availability zone for subnet 1"
    type        = string
    default     = "us-east-2"
    }
variable "public_key_path" {
    description = "The path to the public key file"
    type        = string
    default     = "~/.ssh/levelup_key.pub"
    }
   variable "ami_id" {
    description = "The AMI ID for the EC2 instance"
    type        = string
    default     = "ami-05803413c51f242b7"
    }

    variable "instance_type" {  
    description = "The instance type for the EC2 instance"
    type        = string
    default     = "t2.micro"
    }  
