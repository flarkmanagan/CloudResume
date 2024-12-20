resource "aws_apigatewayv2_api" "lambda_http_api" {
  name = var.api_name
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
  }
}

resource "aws_apigatewayv2_route" "api_route" {
  api_id = aws_apigatewayv2_api.lambda_http_api.id
  route_key = "GET /VisitorCounterUpdater"
  target = "integrations/${aws_apigatewayv2_integration.api_lambda_integration.id}"
}

resource "aws_apigatewayv2_integration" "api_lambda_integration" {
   api_id = aws_apigatewayv2_api.lambda_http_api.id
   integration_type = "AWS_PROXY"
   connection_type = "INTERNET"
   integration_method = "POST"
   integration_uri = aws_lambda_function.lambda_counter.invoke_arn
}

/*
resource "aws_apigatewayv2_integration_response" "api_lambda_integration_response" {
  api_id                   = aws_apigatewayv2_api.lambda_http_api.id
  integration_id           = aws_apigatewayv2_integration.api_lambda_integration.id
  integration_response_key = "/200/"

  depends_on = [ aws_apigatewayv2_api.lambda_http_api ]
}
*/

resource "aws_apigatewayv2_stage" "name" {
  name = "$default"
  api_id                   = aws_apigatewayv2_api.lambda_http_api.id
  auto_deploy = "true"

}