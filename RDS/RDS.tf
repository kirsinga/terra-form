resource "aws_db_subnet_group" "levelup_mariadb_subnet_group" {
  name       = "levelup_mariadb_subnet_group"
  subnet_ids = [aws_subnet.levelup_subnet1.id, aws_subnet.levelup_subnet2.id]

  tags = {
    Name = "levelup_mariadb_subnet_group"
  }
  
}
//RDS Parameter Group
resource "aws_db_parameter_group" "levelup_mariadb_parameter_group" {
  name        = "levelup-mariadb-parameter-group"
  family      = "mariadb10.11"
  description = "Custom parameter group for MariaDB"
 
  parameter {
    name="max_allowed_packet"
    value="16777216"
  }
  tags = {
    Name = "levelup-mariadb-parameter-group"
  }
}

resource "aws_security_group" "allow_mariadb" {
  name        = "allow_mariadb"
  description = "Security group for allow mariadb"
  vpc_id      = aws_vpc.vpc_levelup.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.levelup_allow_ssh.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_mariadb"
  }
}

resource "aws_db_instance" "levelup_mariadb_instance" {
  identifier              = "mariadb"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mariadb"
  engine_version          = "10.11"
  instance_class          = "db.t3.micro"
  db_name                 = "mariadb"
  username                = "root"
  password                = "password123"
  db_subnet_group_name    = aws_db_subnet_group.levelup_mariadb_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.allow_mariadb.id]
  parameter_group_name    = aws_db_parameter_group.levelup_mariadb_parameter_group.name
  skip_final_snapshot     = true
  multi_az = false
  backup_retention_period = 30
  availability_zone = aws_subnet.levelup_subnet1.availability_zone



  tags = {
    Name = "levelup_mariadb_instance"
  }
}
output "name" {
     value = aws_db_instance.levelup_mariadb_instance.endpoint
}