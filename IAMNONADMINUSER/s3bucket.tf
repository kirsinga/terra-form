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

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "levelup-bucket" {
	bucket = aws_s3_bucket.levelup-bucket.id
	policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
			{
				Sid    = "AllowAccountAndEC2RoleObjectAccess"
				Effect = "Allow"
				Principal = {
					AWS = [
						"arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
						aws_iam_role.levelup-s3-access-role.arn
					]
				}
				Action = [
					"s3:ListBucket",
					"s3:GetObject",
					"s3:PutObject"
				]
				Resource = [
					aws_s3_bucket.levelup-bucket.arn,
					"${aws_s3_bucket.levelup-bucket.arn}/*"
				]
			}
		]
	})
}


