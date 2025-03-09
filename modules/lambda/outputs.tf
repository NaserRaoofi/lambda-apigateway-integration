output "lambda_function_arn" {
  description = "ARN of the created Lambda function"
  value       = aws_lambda_function.lambda_function.arn
}

output "lambda_function_invoke_arn" {
  description = "Invoke ARN of the created Lambda function"
  value       = aws_lambda_function.lambda_function.invoke_arn
}

output "lambda_function_name" {
  description = "Name of the created Lambda function"
  value       = aws_lambda_function.lambda_function.function_name
}
