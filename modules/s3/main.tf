provider "aws" {
  region = var.aws_region
}

# Create S3 Bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

# Disable Block Public Access Settings (Allow Public Read)
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket                  = aws_s3_bucket.public_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Add S3 Bucket Policy to Allow Lambda to Write
resource "aws_s3_bucket_policy" "lambda_access_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowLambdaPutObject",
        Effect    = "Allow",
        Principal = {
          "AWS": "arn:aws:iam::${var.aws_account_id}:role/LambdaS3AccessRole"
        },
        Action    = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource  = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}
