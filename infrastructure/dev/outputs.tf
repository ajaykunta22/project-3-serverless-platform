output "environment" {
  value = var.environment
}
output "frontend_bucket_name" {
  value = module.s3_frontend.frontend_bucket_name
}

output "frontend_website_endpoint" {
  value = module.s3_frontend.frontend_website_endpoint
}
output "images_bucket_name" {
  value = module.s3_images.images_bucket_name
}
output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  value = module.dynamodb.table_arn
}
output "create_inspection_lambda_name" {
  value = module.lambda.create_inspection_lambda_name
}

output "create_inspection_lambda_arn" {
  value = module.lambda.create_inspection_lambda_arn
}
output "api_endpoint" {
  value = module.api_gateway.api_endpoint
}

output "api_id" {
  value = module.api_gateway.api_id
}
output "generate_upload_url_lambda_name" {
  value = module.lambda.generate_upload_url_lambda_name
}

output "generate_upload_url_lambda_arn" {
  value = module.lambda.generate_upload_url_lambda_arn
}
output "sns_topic_arn" {
  value = module.sns_sqs.sns_topic_arn
}

output "sqs_queue_url" {
  value = module.sns_sqs.sqs_queue_url
}

output "sqs_queue_arn" {
  value = module.sns_sqs.sqs_queue_arn
}
output "process_inspection_event_lambda_name" {
  value = module.lambda.process_inspection_event_lambda_name
}

output "process_inspection_event_lambda_arn" {
  value = module.lambda.process_inspection_event_lambda_arn
}