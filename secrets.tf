resource "aws_secretsmanager_secret" "basic_auth_secret" {
  name        = "basic_auth_${var.env}"
  description = "Basic_auth_secret secrets"
}
resource "random_id" "random_password_for_basic_auth" {
  byte_length = 15
}

resource "aws_secretsmanager_secret_version" "basic_auth_secret_version" {
  secret_id = aws_secretsmanager_secret.basic_auth_secret.id
  secret_string = jsonencode({
    BASIC_AUTH_PASSWORD = random_id.random_password_for_basic_auth.id
  })
}