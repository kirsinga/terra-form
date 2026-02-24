data "aws_ip_ranges" "current" {
  regions = ["us-east-1"]
  services = ["ec2"]
}
resource "aws_security_group" "sg_custome_us_east" {
  name        = "sg_custome_us_east"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = data.aws_ip_ranges.current.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    CreateDate = data.aws_ip_ranges.current.create_date
    SyncToken  = data.aws_ip_ranges.current.sync_token
  }

}