resource "aws_route53_record" "basic_auth" {
  name    = "basic-auth-bucket.${var.domain_name}"
  type    = "A"
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.bucket_basic_auth_cf.domain_name
    zone_id                = "Z2FDTNDATAQYW2"
  }
}