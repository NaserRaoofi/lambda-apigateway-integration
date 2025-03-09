variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "us-east-1"
}

variable "lambda_role_name" {
  description = "IAM role name for Lambda"
  default     = "LambdaS3AccessRole"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket Lambda will access"
  default     = "my-public-s3-bucket"
}
