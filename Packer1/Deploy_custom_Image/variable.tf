//vairble file for vpc module 
variable "vpcname" {
  description = "The name of the VPC"
  type        = string
}

variable "vpcenvironment" {
  description = "The environment of the VPC"
  type        = string
  default = "Development"

}   
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}
variable "subnet1_cidr" {
  description = "The CIDR block for subnet 1"
  type        = string
  default     = "10.1.0.0/24"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}
    
variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}
//create variable var.subnet1_cidr
variable "enable_classiclink" {
  description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = null
}
//cider block for subnet 1
variable "enable_classiclink_dns_support" {
  description = "Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = null
}
//variable for subnet available zone 
variable "subnet1_az" {
  description = "The availability zone for subnet 1"
  type        = string
  default     = "us-east-2"
}
//variable for public key name 
variable "public_key_path" {
  description = "The path to the public Key file to use for EC2 instances"
  type        = string
  default     = "~/.ssh/levelup_key.pub"
}


