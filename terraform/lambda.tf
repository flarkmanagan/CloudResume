data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_logging" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "aws_iam_policy_document" "ddb_get_update_policy_doc" {
  statement {
    sid = "DynamoDBGetAndUpdatePolicy"
    effect = "Allow"
    
    actions = [
      "dynamodb:GetItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      aws_dynamodb_table.ddb_table.arn
    ]

  }
}

resource "aws_iam_policy" "ddb_get_update_policy" {
  name = "ddb-policy"
  description = "IAM policy for ddb get and update access for lambda func"
  policy = data.aws_iam_policy_document.ddb_get_update_policy_doc.json
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging.json
}

resource "aws_iam_role" "lambda_role" {
  name = "AWSLambdaExecution_CloudResChallenge"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "attach_ddb_policy" {
  role = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.ddb_get_update_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_lambda_logging" {
  role = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_lambda_permission" "lambda_allow_http_api" {
  statement_id = "AllowHTTPAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_counter.function_name
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.lambda_http_api.execution_arn}/*/*/${var.lambda_name}"
}


data "archive_file" "lambda" {
  type = "zip"
  source_file = "../backend/lambda_function.py"
  output_path = "../terraform/lambda_function_payload.zip"
}

resource "aws_lambda_function" "lambda_counter" {
  architectures = ["x86_64"]
  function_name = var.lambda_name
  handler       = "lambda_function.lambda_handler"
  filename = "lambda_function_payload.zip"

  memory_size                    = "128"
  package_type                   = "Zip"
  reserved_concurrent_executions = "-1"
  role                           = aws_iam_role.lambda_role.arn
  runtime                        = "python3.13"
  skip_destroy                   = "false"

  

  timeout = "3"

  ephemeral_storage {
    size = "512"
  }

  tracing_config {
    mode = "PassThrough"
  }

  logging_config {
    log_format = "Text"
  }
}