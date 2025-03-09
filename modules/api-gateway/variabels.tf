variable "lambda_function_invoke_arn" {
  description = "Invoke ARN of the Lambda function to be triggered by API Gateway"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to be triggered by API Gateway"
  type        = string
}
