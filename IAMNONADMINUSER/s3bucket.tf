//create AWS S3 bucket
resource "aws_s3_bucket" "levelup-bucket" {
  bucket = "levelup-bucket-terraform"
  tags = {
    name = "levelup-bucket-terraform"
  }
}

resource "aws_s3_bucket_ownership_controls" "levelup-bucket" {
  bucket = aws_s3_bucket.levelup-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "levelup-bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.levelup-bucket]
  bucket     = aws_s3_bucket.levelup-bucket.id
  acl        = "private"
}

