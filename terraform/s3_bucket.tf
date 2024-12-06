resource "aws_s3_bucket" "web_bucket" {
  bucket        = var.bucket_name
  force_destroy = "false"

}

resource "aws_s3_bucket_policy" "web_bucket" {
  bucket = aws_s3_bucket.web_bucket.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::markflanagan.org/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::905418439559:distribution/EBR6IBUN75HCD"
                }
            }
        }
    ]
  })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "web_bucket_sse_config" {
  bucket = aws_s3_bucket.web_bucket.id
  
  rule {
   apply_server_side_encryption_by_default {
    sse_algorithm     = "aws:kms"
   }
   bucket_key_enabled = true 
  }
}
