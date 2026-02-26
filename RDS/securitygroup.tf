resource "aws_security_group" "levelup_allow_ssh" {
  name        = "levelup_allow_ssh"
  description = "Security group for levelup VPC"
  vpc_id      = aws_vpc.vpc_levelup.id

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
