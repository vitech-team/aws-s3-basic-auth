provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

resource "aws_cloudfront_origin_access_identity" "basic_auth_access_identity" {
  comment = "access-identity-for-${aws_s3_bucket.basic_auth_bucket.id}"
}

##### S3 PART #####
resource "aws_s3_bucket" "basic_auth_bucket" {
  bucket = "basic-auth-bucket-${var.env}"
  tags = {
    Name    = "basic-auth-bucket-${var.env}"
    Env     = var.env
    Creator = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "basic_auth_bucket_versioning" {
  bucket = aws_s3_bucket.basic_auth_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "basic_auth_bucket_server_side_encryption_configuration" {
  bucket = "basic-auth-bucket-${var.env}"
  rule {
    bucket_key_enabled = false
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "basic_auth_bucket_block_monitoring_public_s3" {
  depends_on = [
    aws_s3_bucket.basic_auth_bucket
  ]
  bucket                  = aws_s3_bucket.basic_auth_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "basic_auth_bucket_policy" {
  depends_on = [
    aws_s3_bucket_public_access_block.basic_auth_bucket_block_monitoring_public_s3
  ]
  bucket = aws_s3_bucket.basic_auth_bucket.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal":{
              "AWS":"${aws_cloudfront_origin_access_identity.basic_auth_access_identity.iam_arn}"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.basic_auth_bucket.arn}/*"
        }
    ]
}
POLICY

}

resource "aws_cloudfront_distribution" "bucket_basic_auth_cf" {
  origin {
    domain_name = aws_s3_bucket.basic_auth_bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.basic_auth_bucket.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.basic_auth_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.env}-Basic--Auth-Distribution"
  default_root_object = "index.html"
  aliases             = [var.basic_auth_domain_name]
  price_class         = "PriceClass_All"
  wait_for_deployment = true

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.certificate.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.basic_auth_bucket.id
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 1
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type = "viewer-request"
      lambda_arn = data.aws_lambda_function.basic_auth_lambda_function.qualified_arn
    }
  }

  tags = {
    Environment = var.env
  }
}