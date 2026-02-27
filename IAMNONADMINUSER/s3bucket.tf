//create AWS S3 bucket
resource "aws_s3_bucket" "levelup_bucket" {
  bucket = "levelup-bucket-terraform"
  tags = {
    name = "levelup-bucket-terraform"
  }
}

