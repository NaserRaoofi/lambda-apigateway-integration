module "s3" {
  source      = "../../modules/s3"
  aws_region  = "eu-west-2"
  bucket_name = "my-public-s3-bucket-sir1"
}

module "iam" {
  source           = "../../modules/iam"
  lambda_role_name = "LambdaS3AccessRole"
}

module "lambda" {
  source              = "../../modules/lambda"
  lambda_function_name = "my_lambda_function"
  lambda_role_arn      = module.iam.lambda_role_arn
  aws_region           = "eu-west-2"
  bucket_name          = "my-public-s3-bucket-sir1"
}

module "api_gateway" {
  source = "../../modules/api-gateway"
  lambda_function_invoke_arn = module.lambda.lambda_function_invoke_arn
  lambda_function_name       = module.lambda.lambda_function_name
}

