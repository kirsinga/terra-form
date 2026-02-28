//auto scalling launch template
resource "aws_launch_template" "lt" {
  name_prefix   = "lt-"
  image_id      = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg_instance.id]
  user_data = base64encode(<<-EOF
    #!/bin/bash
    if command -v apt-get >/dev/null 2>&1; then
      apt-get update -y
      apt-get install -y nginx
      systemctl enable nginx
      systemctl start nginx
    elif command -v yum >/dev/null 2>&1; then
      yum update -y
      amazon-linux-extras install nginx1 -y || yum install -y nginx
      systemctl enable nginx
      systemctl start nginx
    fi
    MYIP=$(hostname -I | awk '{print $1}')
    echo 'Hello Team
    This is my IP: '$MYIP > /var/www/html/index.html
    EOF
  )
 lifecycle {
    create_before_destroy = true

 }
}

resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
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
  vpc_zone_identifier = [aws_subnet.levelup_subnet1.id, aws_subnet.levelup_subnet2.id]
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
      from_port   = 80
      to_port     = 80
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
