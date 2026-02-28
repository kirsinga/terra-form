//auto scalling launch template
resource "aws_launch_template" "lt" {
  name_prefix   = "lt-"
  image_id      = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name
  security_group_names = [aws_security_group.ec2_sg_instance.name]
  user_data  = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Team\nThis is my IP: '$MYIP > /var/www/html/index.html"
 lifecycle {
    create_before_destroy = true

 }
}

resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}
//auto scalling group
resource "aws_autoscaling_group" "levelup_asg" {
  name_prefix        = "levelup-asg-"
  max_size           = 2
  min_size           = 2
  desired_capacity   = 2
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  vpc_zone_identifier = data.aws_subnets.default_subnets.ids
  health_check_grace_period = 200
  health_check_type = "ELB"
  load_balancers = [aws_elb.levelupelb.name]
  force_delete = true
  tag {
    key = "Name"
    value = "Level Up Customer EC2 Instace"
    propagate_at_launch = true
  }

}
//output  for elb dns name 
output "elb_dns_name" {
  value = aws_elb.levelupelb.dns_name
}
//security group for EC2 instances
resource "aws_security_group" "ec2_sg_instance" {    
    name        = "ec2_sg_instance"
    description = "Allow HTTP traffic from ELB to EC2 instances"
    vpc_id      = aws_vpc.vpc_levelup.id
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }
      
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        security_groups = [aws_security_group.elb_sg.id]
    }
    egress  {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags ={
        Name = "ec2_sg_instance"
    }
}
