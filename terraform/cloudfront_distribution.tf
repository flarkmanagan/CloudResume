resource "aws_cloudfront_distribution" "s3_distribution" {

  origin {
    connection_attempts      = "3"
    connection_timeout       = "10"
    origin_access_control_id = aws_cloudfront_origin_access_control.cf_oac.id
    domain_name              = aws_s3_bucket.web_bucket.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.web_bucket.bucket_regional_domain_name
  }

  default_cache_behavior {
    #cache policy id for CachingOptimized
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods        = ["HEAD", "GET"]
    cached_methods         = ["GET", "HEAD"]
    compress               = "true"
    smooth_streaming       = "false"
    target_origin_id       = aws_s3_bucket.web_bucket.bucket_regional_domain_name
    viewer_protocol_policy = "redirect-to-https"
  }

  enabled         = "true"
  http_version    = "http2"
  is_ipv6_enabled = "true"
  price_class = "PriceClass_All"
  retain_on_delete = "false"
  staging          = "false"
  default_root_object = "index.html"
  aliases = ["markflanagan.org"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:905418439559:certificate/e1a27472-1f84-4a78-9464-d54ac6d3bbda"
    cloudfront_default_certificate = "false"
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_control" "cf_oac" {
  name                              = aws_s3_bucket.web_bucket.bucket_regional_domain_name
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
