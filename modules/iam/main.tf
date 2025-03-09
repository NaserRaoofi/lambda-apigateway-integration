provider "aws" {
  region = var.aws_region
}

# IAM Role for Lambda Function
resource "aws_iam_role" "lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Check if IAM Policy Already Exists
data "aws_iam_policy" "existing_lambda_s3_policy" {
  name = "LambdaS3AccessPolicy"
}

# IAM Policy to Allow Lambda to Access S3 (Only Create if It Doesn't Exist)
resource "aws_iam_policy" "lambda_s3_policy" {
  count       = length(data.aws_iam_policy.existing_lambda_s3_policy) == 0 ? 1 : 0
  name        = "LambdaS3AccessPolicy"
  description = "IAM policy to allow Lambda to access S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })
}

# Attach Policy to IAM Role (Use Existing Policy if Found)
resource "aws_iam_role_policy_attachment" "lambda_s3_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = length(data.aws_iam_policy.existing_lambda_s3_policy) > 0 ? data.aws_iam_policy.existing_lambda_s3_policy.arn : aws_iam_policy.lambda_s3_policy[0].arn
}
