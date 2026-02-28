//ELB creation
resource "aws_elb" "levelupelb" {
  name               = "levelupelb"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.levelup_subnet1.id, aws_subnet.levelup_subnet2.id]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

cross_zone_load_balancing = true
connection_draining = true
connection_draining_timeout = 400
  tags = {
    Name        = "levelupelb"
    Environment = "production"
  }
}
//security group for ELB
resource "aws_security_group" "elb_sg" {    
    name        = "elb_sg"
    description = "Allow HTTP traffic to ELB"
    vpc_id      = aws_vpc.vpc_levelup.id
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress  {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags ={
        Name = "elb_sg"
    }
}
