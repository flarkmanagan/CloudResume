output "cloudfront_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "api_invoke_url" {
  value = aws_apigatewayv2_stage.api_stage.invoke_url
}

