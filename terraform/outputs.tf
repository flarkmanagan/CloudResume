output "cloudfront_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

/*
output "api_invoke_url" {
  value = aws_api_gateway_stage.api_stage_prod.invoke_url
}
*/
