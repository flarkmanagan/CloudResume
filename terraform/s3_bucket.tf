resource "aws_s3_bucket" "web_bucket" {
  bucket        = var.bucket_name
  force_destroy = "false"

}

resource "aws_s3_bucket_policy" "web_bucket_policy" {
  bucket = aws_s3_bucket.web_bucket.id
  policy = data.aws_iam_policy_document.web_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "web_bucket_sse_config" {
  bucket = aws_s3_bucket.web_bucket.id
  
  rule {
   apply_server_side_encryption_by_default {
    sse_algorithm     = "AES256"
   }
   bucket_key_enabled = true 
  }
}

/*
resource "aws_s3_object" "html" {
  bucket = aws_s3_bucket.web_bucket.bucket
  key = "index.html"
  source = "${path.module}/../index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "js" {
  bucket = aws_s3_bucket.web_bucket.bucket
  key = "scripts/LambdaCaller.js"
  source = "${path.module}/../scripts/LambdaCaller.js"
  content_type = "application/javascript"
}
*/