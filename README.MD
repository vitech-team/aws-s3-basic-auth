Configuration

Before using the middleware, you'll need to configure the following environment variables:

S3_BUCKET_NAME: The name of the S3 bucket where your files are stored.
BASIC_AUTH_USERNAME: The username for the basic authentication.
BASIC_AUTH_PASSWORD: The password for the basic authentication.
You can set these environment variables in a .env file in the root of the project:

S3_BUCKET_NAME=your_s3_bucket_name
BASIC_AUTH_USERNAME=your_basic_auth_username
BASIC_AUTH_PASSWORD=your_basic_auth_password

module "monitoring_basic_auth" {
source = "git::ssh://git@github.com/vitech-team/aws-s3-basic-auth.git?ref=<git tag>"
name_prefix      = "sftp"
parameter_prefix = "/example/prefix"
}
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.56.0 |
| <a name="provider_aws.virginia"></a> [aws.virginia](#provider\_aws.virginia) | 4.56.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.3.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.bucket_basic_auth_cf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.basic_auth_access_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_iam_policy.lambda_log_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.basic_auth_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_log_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda_basic_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_route53_record.basic_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.basic_auth_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.basic_auth_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.basic_auth_bucket_block_monitoring_public_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.basic_auth_bucket_server_side_encryption_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.basic_auth_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_secretsmanager_secret.basic_auth_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.basic_auth_secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [local_sensitive_file.config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [null_resource.lambda_file](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.random_password_for_basic_auth](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [archive_file.lambda_archive](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_acm_certificate.certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_iam_policy_document.lambda_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_log_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lambda_function.basic_auth_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lambda_function) | data source |
| [aws_route53_zone.domain_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-east-1"` | no |
| <a name="input_basic_auth_domain_name"></a> [basic\_auth\_domain\_name](#input\_basic\_auth\_domain\_name) | Set S3\_basic\_auth\_domain\_name | `string` | n/a | yes |
| <a name="input_basic_auth_user"></a> [basic\_auth\_user](#input\_basic\_auth\_user) | Username for Basic auth | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Set domain\_name | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Set environment | `string` | `"prod"` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Insert lambda name | `string` | `"lambda_function_basic_auth"` | no |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
