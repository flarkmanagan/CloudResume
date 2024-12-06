
# ~~~~~~~~~~~~~~~~~~~~~~ API Gateway resource ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

resource "aws_api_gateway_resource" "tfer--qnbbup" {
  parent_id   = "qwr7tuwpy7"
  path_part   = "update-count"
  rest_api_id = "f9fm79pz96"
}

resource "aws_api_gateway_resource" "tfer--qwr7tuwpy7" {
  parent_id   = ""
  path_part   = ""
  rest_api_id = "f9fm79pz96"
}

# ~~~~~~~~~~~~~~~~~~~~~~ API Gateway REST API ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

resource "aws_api_gateway_rest_api" "tfer--VisitorCounterUpdaterAPI" {
  api_key_source               = "HEADER"
  disable_execute_api_endpoint = "false"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  name = "VisitorCounterUpdaterAPI"
}

# ~~~~~~~~~~~~~~~~~~~~~~ API Gateway stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


resource "aws_api_gateway_stage" "tfer--f9fm79pz96-002F-prod" {
  cache_cluster_enabled = "false"
  deployment_id         = "81lf3z"
  rest_api_id           = "f9fm79pz96"
  stage_name            = "prod"
  xray_tracing_enabled  = "false"
}


# ~~~~~~~~~~~~~~~~~~~~~~ API Gateway integration ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



resource "aws_api_gateway_gateway_response" "tfer--f9fm79pz96-002F-DEFAULT_4XX" {
  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "gatewayresponse.header.Access-Control-Allow-Methods" = "'GET'"
    "gatewayresponse.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = "{\"message\":$context.error.messageString}"
  }

  response_type = "DEFAULT_4XX"
  rest_api_id   = "f9fm79pz96"
}

resource "aws_api_gateway_gateway_response" "tfer--f9fm79pz96-002F-DEFAULT_5XX" {
  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "gatewayresponse.header.Access-Control-Allow-Methods" = "'GET'"
    "gatewayresponse.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = "{\"message\":$context.error.messageString}"
  }

  response_type = "DEFAULT_5XX"
  rest_api_id   = "f9fm79pz96"
}


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ API Gateway integration ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

resource "aws_api_gateway_integration" "tfer--f9fm79pz96-002F-qnbbup-002F-GET" {
  cache_namespace         = "qnbbup"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "GET"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "qnbbup"
  rest_api_id             = "f9fm79pz96"
  timeout_milliseconds    = "29000"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:eu-west-1:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-1:905418439559:function:VisitorCounterUpdater/invocations"
}

resource "aws_api_gateway_integration" "tfer--f9fm79pz96-002F-qnbbup-002F-OPTIONS" {
  cache_namespace      = "qnbbup"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "qnbbup"
  rest_api_id          = "f9fm79pz96"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}


resource "aws_api_gateway_integration_response" "tfer--f9fm79pz96-002F-qnbbup-002F-GET-002F-200" {
  http_method = "GET"
  resource_id = "qnbbup"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'https://markflanagan.org'"
  }

  rest_api_id = "f9fm79pz96"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "tfer--f9fm79pz96-002F-qnbbup-002F-OPTIONS-002F-200" {
  http_method = "OPTIONS"
  resource_id = "qnbbup"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'https://markflanagan.org'"
  }

  rest_api_id = "f9fm79pz96"
  status_code = "200"
}


# ~~~~~~~~~~~~~~~~~~~~~~ API Gateway method ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


resource "aws_api_gateway_method" "tfer--f9fm79pz96-002F-qnbbup-002F-GET" {
  api_key_required     = "false"
  authorization        = "NONE"
  http_method          = "GET"
  request_validator_id = "n62okt"
  resource_id          = "qnbbup"
  rest_api_id          = "f9fm79pz96"
}

resource "aws_api_gateway_method" "tfer--f9fm79pz96-002F-qnbbup-002F-OPTIONS" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = "qnbbup"
  rest_api_id      = "f9fm79pz96"
}


resource "aws_api_gateway_method_response" "tfer--f9fm79pz96-002F-qnbbup-002F-GET-002F-200" {
  http_method = "GET"
  resource_id = "qnbbup"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "false"
  }

  rest_api_id = "f9fm79pz96"
  status_code = "200"
}

resource "aws_api_gateway_method_response" "tfer--f9fm79pz96-002F-qnbbup-002F-OPTIONS-002F-200" {
  http_method = "OPTIONS"
  resource_id = "qnbbup"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "false"
    "method.response.header.Access-Control-Allow-Methods" = "false"
    "method.response.header.Access-Control-Allow-Origin"  = "false"
  }

  rest_api_id = "f9fm79pz96"
  status_code = "200"
}


# ~~~~~~~~~~~~~~~~~~~~~~ API Gateway model ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

resource "aws_api_gateway_model" "tfer--hbcow4" {
  content_type = "application/json"
  description  = "This is a default empty schema model"
  name         = "Empty"
  rest_api_id  = "f9fm79pz96"
  schema       = "{\n  \"$schema\": \"http://json-schema.org/draft-04/schema#\",\n  \"title\" : \"Empty Schema\",\n  \"type\" : \"object\"\n}"
}

resource "aws_api_gateway_model" "tfer--pont6u" {
  content_type = "application/json"
  description  = "This is a default error schema model"
  name         = "Error"
  rest_api_id  = "f9fm79pz96"
  schema       = "{\n  \"$schema\" : \"http://json-schema.org/draft-04/schema#\",\n  \"title\" : \"Error Schema\",\n  \"type\" : \"object\",\n  \"properties\" : {\n    \"message\" : { \"type\" : \"string\" }\n  }\n}"
}
