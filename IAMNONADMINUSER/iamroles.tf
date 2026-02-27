//rolls to access s3 bucket
resource "aws_iam_role" "levelup-s3-access-role" {
  name = "levelup_s3_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        sid=""
        Action = "sts:AssumeRole"
      }
    ]
  })
}
//policy  to attach the  s3 Bucket  role
resource "aws_iam_role_policy" "levelup-s3-access-attachment" {
  role  = aws_iam_role.levelup-s3-access-role.name
  policy= jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*"
                ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.levelup-bucket.id}",
          "arn:aws:s3:::${aws_s3_bucket.levelup-bucket.id}/*"
        ]
      }
    ]
  })
  
}
//instace Identifier
resource "aws_iam_instance_profile" "levelup-s3-access-instance-profile" {
  name = "levelup-s3-access-instance-profile"
  role = aws_iam_role.levelup-s3-access-role.name
}