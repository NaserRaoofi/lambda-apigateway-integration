resource "aws_lambda_function" "lambda_function" {
  function_name    = var.lambda_function_name
  role             = var.lambda_role_arn
  handler          = "lambda_function.lambda_handler"  # Matches the file `handler.py`
  runtime          = "python3.9"
  filename         = "${path.module}/S3HandlerFunction/lambda_function.zip"  # Ensure filename matches zip file
  source_code_hash = filebase64sha256("${path.module}/S3HandlerFunction/lambda_function.zip")  # Track changes

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name  # Inject bucket name as environment variable
    }
  }
}
