data "aws_acm_certificate" "certificate" {
  domain      = "*.${var.domain_name}"
  most_recent = true
  provider    = aws.virginia
}

data "aws_lambda_function" "basic_auth_lambda_function" {
  function_name = var.lambda_name
  depends_on    = [aws_lambda_function.lambda_basic_auth]
}

data "aws_route53_zone" "domain_zone" {
  name         = "${var.domain_name}."
  private_zone = false
}
