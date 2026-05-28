locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = "Ajay"
  }
}

module "s3_frontend" {
  source = "../../modules/s3-frontend"

  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}

module "s3_images" {
  source = "../../modules/s3-images"

  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}

module "dynamodb" {
  source = "../../modules/dynamodb"

  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}

module "lambda" {
  source = "../../modules/lambda"

  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags

  lambda_zip_path     = "../../backend/lambdas/create-inspection/create-inspection.zip"
  dynamodb_table_name = module.dynamodb.table_name
  dynamodb_table_arn  = module.dynamodb.table_arn

  upload_url_lambda_zip_path = "../../backend/lambdas/generate-upload-url/generate-upload-url.zip"
  images_bucket_name         = module.s3_images.images_bucket_name
  images_bucket_arn          = module.s3_images.images_bucket_arn
  worker_lambda_zip_path     = "../../backend/lambdas/process-inspection-event/process-inspection-event.zip"
  sqs_queue_arn              = module.sns_sqs.sqs_queue_arn
}

module "api_gateway" {
  source = "../../modules/api-gateway"

  project_name = var.project_name
  environment  = var.environment

  lambda_arn  = module.lambda.create_inspection_lambda_arn
  lambda_name = module.lambda.create_inspection_lambda_name

  upload_url_lambda_arn  = module.lambda.generate_upload_url_lambda_arn
  upload_url_lambda_name = module.lambda.generate_upload_url_lambda_name
}
module "sns_sqs" {
  source = "../../modules/sns"

  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}