resource "aws_apigatewayv2_api" "lambda_http_api" {
  name = var.api_name
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
  }
}

resource "aws_apigatewayv2_route" "api_route" {
  api_id = aws_apigatewayv2_api.lambda_http_api.id
  route_key = "GET /${var.lambda_name}" # change string to "/VisitorCounterUpdater" if var ref doesn't work
  target = "integrations/${aws_apigatewayv2_integration.api_lambda_integration.id}"
}

resource "aws_apigatewayv2_integration" "api_lambda_integration" {
  api_id = aws_apigatewayv2_api.lambda_http_api.id
  integration_type = "AWS_PROXY"
  connection_type = "INTERNET"
  integration_method = "POST"
  integration_uri = aws_lambda_function.lambda_counter.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  name = "$default"
  api_id = aws_apigatewayv2_api.lambda_http_api.id
  auto_deploy = "false"
}