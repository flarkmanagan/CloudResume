data "archive_file" "lambda_init_db_archive" {
  type = "zip"
  source_file = "../init_db.py"
  output_path = "../terraform/init_db_payload.zip"
}



resource "aws_lambda_function" "lambda_init_db" {
  architectures = ["x86_64"]
  function_name = var.lambda_db_init_name
  handler       = "init_db.lambda_handler"
  filename = "init_db_payload.zip"

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


resource "aws_lambda_function_url" "lambda_init_db_url" {
  function_name = aws_lambda_function.lambda_init_db.function_name
  authorization_type = "NONE"

  cors {
    allow_origins = "*"
    allow_methods = "*"
  }

  depends_on = [ aws_lambda_function.lambda_init_db ]
}