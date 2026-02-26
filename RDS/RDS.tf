resource "aws_db_subnet_group" "levelup_mariadb_subnet_group" {
  name       = "levelup_mariadb_subnet_group"
  subnet_ids = [aws_subnet.levelup_subnet1.id, aws_subnet.levelup_subnet2.id]

  tags = {
    Name = "levelup_mariadb_subnet_group"
  }
  
}
//RDS Parameter Group
resource "aws_db_parameter_group" "levelup_mariadb_parameter_group" {
  name        = "levelup_mariadb_parameter_group"
  family      = "mariadb10.5"
  description = "Custom parameter group for MariaDB"
 
  parameter {
    name="max_allowed_packet"
    value="16777216"
  }
  tags = {
    Name = "levelup_mariadb_parameter_group"
  }
}

resource "aws_db_instance" "levelup_mariadb_instance" {
  identifier              = "mariadb"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mariadb"
  engine_version          = "10.5"
  instance_class          = "db.t2.micro"
  db_name                 = "mariadb"
  username                = "root"
  password                = "password123"
  db_subnet_group_name    = aws_db_subnet_group.levelup_mariadb_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.allow_mariadb.id]
  parameter_group_name    = aws_db_parameter_group.levelup_mariadb_parameter_group.name
  skip_final_snapshot     = true
  multi_az = "false"
  backup_retention_period = 30
  availability_zone = aws_subnet.levelup_subnet1.availability_zone



  tags = {
    Name = "levelup_mariadb_instance"
  }
}
output "name" {
     value = aws_db_instance.levelup_mariadb_instance.endpoint
}