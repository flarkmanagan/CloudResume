variable "region_name" {
  type = string
  default = "eu-west-1"
}

variable "bucket_name" {
  type = string
}

variable "lambda_name" {
  type = string
}
variable "lambda_db_init_name" {
  type = string
}

variable "api_name" {
  type = string
}

variable "api_resource_name" {
  type = string
}

variable "dynamodb_name" {
  type = string
}

variable "domain_name" {
  type = string
}