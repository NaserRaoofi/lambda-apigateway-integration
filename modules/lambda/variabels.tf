variable "lambda_function_name" {
  description = "The name of the Lambda function"
}

variable "lambda_role_arn" {
  description = "IAM Role ARN for Lambda execution"
}

variable "aws_region" {
  description = "AWS region for Lambda"
}

variable "bucket_name" {
  description = "S3 Bucket name (Used inside Lambda)"
}
