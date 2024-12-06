
data "archive_file" "lambda" {
  type = "zip"
  source_file = "../lambda_ddb.py"
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
  role                           = "arn:aws:iam::905418439559:role/AWSLambdaExecution_CloudResChallenge"
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
    log_group  = "/aws/lambda/VisitorCounterUpdater"
  }

  tags = {
    Project = "CloudResumeChallenge"
  }

  tags_all = {
    Project = "CloudResumeChallenge"
  }
}
