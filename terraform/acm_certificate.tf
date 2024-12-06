resource "aws_acm_certificate" "tfer--b1cb3e91-002D-6d57-002D-4033-002D-8108-002D-5345e72a7081_markflanagan-002E-org" {
  domain_name   = var.domain_name
  key_algorithm = "RSA_2048"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  subject_alternative_names = [var.domain_name]
  validation_method         = "DNS"
}
