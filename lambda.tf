locals {
  lambda_variables = {
    aws_region        = var.aws_region
    basic_auth_user   = var.basic_auth_user
    basic_auth_secret = "basic_auth_${var.env}"
  }
  lambda_path_name = "${path.module}/lambda/${var.lambda_name}.py"
}

resource "null_resource" "lambda_file" {
  count = fileexists(pathexpand(local.lambda_path_name)) ? 0 : 1

  provisioner "local-exec" {
    command = "touch ${local.lambda_path_name}"
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "local_sensitive_file" "config" {
  content         = templatefile("${path.module}/lambda/${var.lambda_name}.tftpl", local.lambda_variables)
  file_permission = "0777"
  filename        = "${path.module}/lambda/${var.lambda_name}.py"
  depends_on      = [null_resource.lambda_file]
}

data "archive_file" "lambda_archive" {
  type        = "zip"
  source_file = local.lambda_path_name
  output_path = "${path.module}/lambda/${var.lambda_name}.zip"
  depends_on = [
    null_resource.lambda_file,
    local_sensitive_file.config
  ]
}

data "aws_iam_policy_document" "lambda_log_access" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "edgelambda.amazonaws.com",
        "lambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "basic_auth_role" {
  name               = "lambda-basic-auth-role-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  path               = "/service-role/"
}

resource "aws_iam_role_policy_attachment" "lambda_log_access" {
  role       = aws_iam_role.basic_auth_role.name
  policy_arn = aws_iam_policy.lambda_log_access.arn
}

resource "aws_iam_policy" "lambda_log_access" {
  name   = "cloudfront_auth_lambda_log_access_${var.env}"
  policy = data.aws_iam_policy_document.lambda_log_access.json
}

resource "aws_lambda_function" "lambda_basic_auth" {
  function_name = var.lambda_name
  description   = "Add Basic Auth for S3 bucket"
  filename      = data.archive_file.lambda_archive.output_path
  handler       = "${var.lambda_name}.lambda_handler"
  role          = aws_iam_role.basic_auth_role.arn
  runtime       = "python3.9"
  publish       = true
  depends_on = [
    local_sensitive_file.config,
    data.archive_file.lambda_archive,
    aws_iam_role.basic_auth_role
  ]
}