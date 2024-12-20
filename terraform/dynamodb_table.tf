resource "aws_dynamodb_table" "ddb_table" {
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = "false"
  hash_key                    = "id"
  name                        = var.dynamodb_name
  read_capacity  = "0"
  stream_enabled = "false"
  table_class    = "STANDARD"
  write_capacity = "0"

  point_in_time_recovery {
    enabled = "false"
  }

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "visitorCount"
    type = "N"
  }
}